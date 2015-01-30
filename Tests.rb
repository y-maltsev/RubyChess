describe "Tests" do
  board = Hash.new
  (1..8).each do |x|
    (1..8).each do |y|
	  board[[x,y]] = nil
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
	  expect(Chess::Pawn.get_move_positions([3,3], "W", board)).to eq [[3,2], [3,1]]
	end
	it "Can remove starting paw" do
	  Chess::Pawn.remove_starting_pawn([3,3])
	  expect(Chess::Pawn.starting_pawns).to eq []
	end
  end
  
  describe "Rook"
end
