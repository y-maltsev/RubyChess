describe "Tests" do
  board = Hash.new
  (1..8).each do |x|
    (1..8).each do |y|
	  board[[x,y]] = nil
	end
  end
  
  
  
  describe "Rook" do
    it "Can move" do
	  expect(Chess::Rook.get_move_positions([3,3], "W", board)).to match_array [[3,2], [3,1], [3,4], [3,5], [3,6], [3,7], [3,8], [2,3], [1,3], [4,3], [5,3], [6,3], [7,3], [8,3]]
	end
	it "Can move with obsticles" do
	  board[[3,1]] = "WP"
	  board[[1,3]] = "WP"
	  board[[5,3]] = "WP"
	  board[[3,5]] = "WP"
	  expect(Chess::Rook.get_move_positions([3,3], "W", board)).to match_array [[3,2], [2,3], [4,3], [3,4]]
	end
	it "Can attack" do
	  board[[3,1]] = "BP"
	  board[[1,3]] = "WP"
	  board[[5,3]] = "BP"
	  board[[3,5]] = "WP"
	  expect(Chess::Rook.get_move_positions([3,3], "W", board)).to match_array [[3,2], [2,3], [4,3], [3,4], [5,3], [3,1]]
	  board[[3,1]] = nil
	  board[[1,3]] = nil
	  board[[5,3]] = nil
	  board[[3,5]] = nil
	end
  end
  
  describe "Bishop" do
    it "Can move" do
	  expect(Chess::Bishop.get_move_positions([3,3], "W", board)).to match_array [[2,2], [1,1], [4,4], [5,5], [6,6], [7,7], [8,8], [2,4], [1,5], [4,2], [5,1]]
	end
	it "Can move with obsticles" do
	  board[[1,1]] = "WP"
	  board[[5,5]] = "WP"
	  board[[5,1]] = "WP"
	  board[[1,5]] = "WP"
	  expect(Chess::Bishop.get_move_positions([3,3], "W", board)).to match_array [[2,2], [4,4], [2,4], [4,2]]
	end
	it "Can attack" do
	  board[[1,1]] = "BP"
	  board[[5,5]] = "WP"
	  board[[5,1]] = "BP"
	  board[[1,5]] = "WP"
	  expect(Chess::Bishop.get_move_positions([3,3], "W", board)).to match_array [[1,1], [5,1], [2,2], [4,4], [2,4], [4,2]]
	  board[[1,1]] = nil
	  board[[5,5]] = nil
	  board[[5,1]] = nil
	  board[[1,5]] = nil
	end
  end
  
  describe "Pawn" do
    it "Can move" do
	  expect(Chess::Pawn.get_move_positions([3,3], "W", board)).to eq [[3,2]]
	end
	it "Can add new starting pawn" do
	  expect(Chess::Pawn.add_starting_pawn([3,3])).to eq [[3,3]]
	end
	it "Can move double when starting" do
	  expect(Chess::Pawn.get_move_positions([3,3], "W", board)).to match_array([[3,1], [3,2]]) 
	end
	it "Can remove starting paw" do
	  Chess::Pawn.remove_starting_pawn([3,3])
	  expect(Chess::Pawn.starting_pawns).to eq []
	end
  end
  
  describe "Knight" do
    it "Can move" do 
	  board[[1,2]] = "WP"
	  expect(Chess::Knight.get_move_positions([3,3], "W", board)).to match_array [[1,4], [2,1], [2,5], [4,1], [4,5], [5,2], [5,4]]
	end
	it "Can attack" do
	  board[[1,2]] = "BP"
	  expect(Chess::Knight.get_move_positions([3,3], "W", board)).to match_array [[1,2], [1,4], [2,1], [2,5], [4,1], [4,5], [5,2], [5,4]]
	  board[[1,2]] = nil
	end
  end
  
  describe "King" do
    it "Can move" do 
	  board[[2,2]] = "WP"
	  board[[3,3]] = "WK"
	  expect(Chess::King.get_move_positions([3,3], "W", board)).to match_array [[2,3], [4,3], [4,2], [3,2], [2,4], [3,4], [4,4]]
	  
	end
	it "Can attack" do
	  board[[2,2]] = "BP"
	  expect(Chess::King.get_move_positions([3,3], "W", board)).to match_array [[2,2], [2,3], [4,3], [4,2], [3,2], [2,4], [3,4], [4,4]]
	  board[[2,2]] = nil
	  board[[3,3]] = nil
	end
  end
  
   describe "Board" do
    class TestBoard < Chess::Board
	  def initialize(type)
	    @rule_type = type
        @board = Hash.new
		@turnColor = "W"
      end
	  
	  def chess_check (color, piece_type)
	    super(color, piece_type)
	  end
	  
	  def chessmate_check(color, piece_type, attacker_pos)
	    super(color, piece_type, attacker_pos)
	  end
	end
	testboard = TestBoard.new 3
	it "Can reset - save and load" do
	  testboard.reset
	  File.open('BoardSave.txt', 'r') do |f1| 
        expect(f1.gets.split[0]).to eq "3"
        expect(f1.gets.split[0]).to eq "W"
        expect(f1.gets).to eq "Br  Bk  Bb  BQ  BK  Bb  Bk  Br\n" 
        expect(f1.gets).to eq "BP  BP  BP  BP  BP  BP  BP  BP\n"
        expect(f1.gets).to eq "n   n   n   n   n   n   n   n \n"
        expect(f1.gets).to eq "n   n   n   n   n   n   n   n \n"
        expect(f1.gets).to eq "n   n   n   n   n   n   n   n \n"
        expect(f1.gets).to eq "n   n   n   n   n   n   n   n \n"        
        expect(f1.gets).to eq "WP  WP  WP  WP  WP  WP  WP  WP\n" 
        expect(f1.gets).to eq "Wr  Wk  Wb  WQ  WK  Wb  Wk  Wr\n"
		expect(f1.gets).to eq "300\n"
		expect(f1.gets).to eq "300\n"
      end
	  expect(testboard.turnColor).to eq "W"
	  expect(testboard.rule_type).to eq 3
	  expect(testboard.board.length).to eq 64
	end
	
	it "Chess check is working" do
	 testboard.board[[4,3]] = "Wk"
	 expect(testboard.chess_check("B","K")).to eq true
	 testboard.board[[4,3]] = nil
	 testboard.board[[6,3]] = "Wk"
	 expect(testboard.chess_check("B","K")).to eq true
	 testboard.board[[6,3]] = nil
	end
	
	it "Can Chessmate" do
	  testboard.board[[5,1]] = nil
	  testboard.board[[2,5]] = "BK"
	  testboard.board[[7,4]] = "Wr"
	  testboard.board[[2,6]] = "Wr"
	  testboard.board[[7,6]] = "Wr"
	  expect(testboard.chess_check("B","K")).to eq true
	  expect(testboard.chessmate_check("B","K",[2,6])).to eq false
	  testboard.board[[7,5]] = "Wr"
	  expect(testboard.chessmate_check("B","K",[7,5])).to eq true
	  testboard.board[[2,6]] = nil
	  testboard.board[[6,3]] = "Br"
	  expect(testboard.chessmate_check("B","K",[7,5])).to eq false
	  testboard.board[[6,3]] = nil
	end
	
	it "Can move figures, auto chess and chessmate check and announce winner" do
	  testboard.board[[6,5]] = "Bp"
	  testboard.handle_event([7,5])
	  expect( testboard.board[[7,5]]).to eq "Wr"
	  expect( testboard.board[[6,5]]).to eq "Bp"
	  expect(testboard.selected).to eq [7,5]
	  testboard.handle_event([6,5])
	  expect( testboard.board[[7,5]]).to eq nil
	  expect( testboard.board[[6,5]]).to eq "Wr"
	  expect(testboard.selected).to eq nil
	  expect(testboard.winner).to eq "W"
	  expect(testboard.turnColor).to eq "B"
	  
	  
	end
 end
  
end
