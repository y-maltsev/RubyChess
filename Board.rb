require "./Pawn.rb"
require "./Queen.rb"
require "./King.rb"
require "./Knight.rb"

module Chess
  class Board  
  attr_accessor :board, :rule_type, :selected , :possible_moves, :turnColor, :winner, :last_time, :turn_time, :turn_time_playerW, :turn_time_playerB

  private
    def init_board
      File.open('BoardSave.txt', 'r') do |f1| 
        if f1.gets.split[0].to_i !=@rule_type 
          reset_board
        else
          choise = ""
          until choise == "y" || choise == "n" do
            print "Load last game?(y/n):"
            choise = gets.strip
          end
          reset_board if choise == "n"
        end
      end
	  load_board
    end
    
	def load_board
	  File.open('BoardSave.txt', 'r') do |f1| 
        f1.gets
        @turnColor = f1.gets.split[0]
        (1..8).each do |y|
          f1.gets.split.each_with_index{ |piece, x | @board[[x+1,y]] = (piece == "n") ? nil : piece }
          board.each{ |k,v| Pawn.add_starting_pawn(k) if v!= nil && v[1]=="P" }
        end
		if(rule_type == 3 ) 
	      @last_time=Time.now 
	      @turn_time_playerW = f1.gets.split[0].to_i
	      @turn_time_playerB = f1.gets.split[0].to_i
	    end
      end
	  if(rule_type == 2 ) 
	    @last_time=Time.now 
	    @turn_time = 30  
	  end
	  @King_piece = "K"
	  @King_piece = "k" if(@rule_type == 4)
	  puts @King_piece
	end
	
    def reset_board
      File.open('BoardSave.txt', 'w') do |f1|
        f1.puts "#{@rule_type}"
		f1.puts "W"
        if((1..3) === @rule_type) 
          f1.puts "Br  Bk  Bb  BQ  BK  Bb  Bk  Br" 
          f1.puts "BP  BP  BP  BP  BP  BP  BP  BP"
          f1.puts "n   n   n   n   n   n   n   n "
          f1.puts "n   n   n   n   n   n   n   n "
          f1.puts "n   n   n   n   n   n   n   n "
          f1.puts "n   n   n   n   n   n   n   n "        
          f1.puts "WP  WP  WP  WP  WP  WP  WP  WP" 
          f1.puts "Wr  Wk  Wb  WQ  WK  Wb  Wk  Wr"
        end
		if (@rule_type == 4)
		  f1.puts "Br  BK  Bb  BQ  Bk  Bb  BK  Br" 
          f1.puts "BP  BP  BP  BP  BP  BP  BP  BP"
          f1.puts "n   n   n   n   n   n   n   n "
          f1.puts "n   n   n   n   n   n   n   n "
          f1.puts "n   n   n   n   n   n   n   n "
          f1.puts "n   n   n   n   n   n   n   n "        
          f1.puts "WP  WP  WP  WP  WP  WP  WP  WP" 
          f1.puts "Wr  WK  Wb  WQ  Wk  Wb  WK  Wr"
        end
		if(@rule_type == 3)
		 f1.puts "300"
		 f1.puts "300"
		end
      end
    end
	
	
	
    def get_piece_moves(position, color)
      moves = []
      case board[position][1]
        when "p" then moves = Pawn.get_move_positions(position, color, board)
        when "P" then moves = Pawn.get_move_positions(position, color, board)
        when "r" then moves = Rook.get_move_positions(position, color, board)
        when "k" then moves = Knight.get_move_positions(position, color, board)    
        when "b" then moves = Bishop.get_move_positions(position, color, board)    
        when "K" then moves = King.get_move_positions(position, color, board)    
        when "Q" then moves = Queen.get_move_positions(position, color, board)    
      end
      moves
    end
     
	def modify_pawn(pos)
	  if(turnColor == "W" && pos[1] ==1) ||  (turnColor == "B" && pos[1] ==8) 
	    board[pos][1] = "Q"
	  elsif board[pos][1] == "P"
	    board[pos][1] = "p"
	  end
	end
	
	def chess_check(color, piece_type) #piece type = which piece to be checked with selected color for chess, normaly "K" = king
	  piece = color+piece_type
	  pos =  board.select{ | k,v| v==piece}.keys[0]
	  result = is_pos_attacked_by_color( color == "W"? "B": "W", pos)
	end
	
	def is_pos_attacked_by_color(enemy_color, pos)
      result = false
	  board.select{ |k,v| v!=nil}.select{ |k,v| v[0]==enemy_color}.keys.each{ |x| result =  result || (get_piece_moves(x, enemy_color).include? pos)}
	  result
	end
	
	def chessmate_check(color, piece_type, attacker_pos)
	  result = true
	  piece = color+piece_type
	  piece_pos =  board.select{ | k,v| v==piece}.keys[0]
	  get_piece_moves(piece_pos, color).each do |x|
	    temp = board[x]
	    board[x] = piece
		board[piece_pos] = nil
		result = false unless is_pos_attacked_by_color( color == "W"? "B": "W", x)
		board[x] = temp
		board[piece_pos] = piece
	  end
	  result = false  if( board[attacker_pos][1] == "k" && is_pos_attacked_by_color(color, attacker_pos))
	  board[piece_pos] = nil
	  (get_piece_moves(attacker_pos, color == "W"? "B": "W").select{ |x|  ([piece_pos[1] ,attacker_pos[1]].min..[piece_pos[1], attacker_pos[1]].max)===x[1] &&
																	      ([piece_pos[0] ,attacker_pos[0]].min..[piece_pos[0], attacker_pos[0]].max)===x[0] &&
																		  x!=piece_pos
																		  } + [attacker_pos])
	   .each{ |x| result = false if is_pos_attacked_by_color(color,x)}
	   board[piece_pos] = piece
	  result
	end
	
	def handle_time
	  time =  @last_time - Time.now
	  @last_time = Time.now
	  if (rule_type == 2)
	    @turn_time += time
		if turn_time < 0 
		  @turn_time = 30
		  @turnColor = @turnColor == "W"? "B": "W"
		end
	  end
	  if (rule_type == 3)
		if turnColor == "W"  
		  @turn_time_playerW += time
		  @winner = "B" if @turn_time_playerW < 0
		else
		  @turn_time_playerB += time
		  @winner = "W" if @turn_time_playerB < 0
		end
	  end
	end
	
  public
    def initialize(type)
	  @rule_type = type
      @board = Hash.new
      #init_game_type
      init_board
      #init_2D if @render_type == 2
      selected = nil
      possible_moves = nil
	  winner = nil
    end
    def update
	   handle_time if( rule_type == 2 || rule_type == 3)
	end
	
	def reset
	  reset_board
	  load_board
	end
	
	def handle_event(selector)
	  
	  unless @rule_type == 2 && @turn_time <0 
        if(@board[selector] !=nil && board[selector][0]==@turnColor)
          @selected = selector
          @possible_moves = get_piece_moves(selector, turnColor)
        elsif @selected !=nil &&  (@possible_moves.include? selector)
	      temp = board[selector]
          board[selector] = board[@selected]
          board[@selected] = nil
		  if ( chess_check( turnColor, @King_piece))
		    board[@selected] = board[selector]
		    board[selector] = temp
		  else
		    modify_pawn(selector) if(board[selector][1]== "P" || board[selector][1] == "p")	
		    @selected = nil
            @possible_moves = []
		    @turnColor= @turnColor == "W" ? "B": "W"
		    if(chess_check( turnColor, @King_piece) && chessmate_check(turnColor, @King_piece, selector)) 
		      @winner = @turnColor == "W" ? "B": "W"
		    end
		  end
        else
          @selected = nil
          @possible_moves = []
        end
	    save_board
	  end
    end
	
    def save_board
	   File.open('BoardSave.txt', 'w') do |f1|
        f1.puts "#{@rule_type}"
		f1.puts "#{@turnColor}"
		f1.puts board.values.map{ |x| x == nil ? x="n  " : x.center(3)}.join("").scan(/.{1,24}/).join("\n")
		f1.puts "#{turn_time_playerW}\n#{turn_time_playerB}" if @rule_type == 3
      end
	  
	end
 
  end
end

#chess = Chess::Board.new
#chess.run