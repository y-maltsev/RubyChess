module Chess
  class Board
  private
    attr_accessor :board, :rule_type, :render_type
	
	def init_game_type
	  choise = 0
	  until (1..3) === choise do
	    puts "Chose Chess rules: 1. Standart 2. timed 3. ???"
		choise = gets.strip.to_i
	  end
	  @rule_type = choise
	  choise = 0
	  until (1..2) === choise do
	    puts "Chose Chess Render type: 1. Command Line 2. 2D"
		choise = gets.strip.to_i
	  end
	  @render_type = choise
	end
	
	
	def init_board
	  File.open('BoardSave.txt', 'r') do |f1| 
		if f1.gets.split[0].to_i !=@rule_type 
		  reset_board(@rule_type) 
		else
		  choise = "a"
		  until choise == "y" || choise == "n" do
		  	puts "Load last game?(y/n):"
		    choise = gets.strip
		  end
		  reset_board(@rule_type) if choise == "n"
		end
	    (1..8).each do |y|
	      f1.gets.split.each_with_index{ |piece, x | @board[[x+1,y]] = (piece == "n")? nil:parse_piece(piece)}		  
	    end
	  end
	end
	
	def init_2D
	
	end
	
	def reset_board(type)
	  File.open('BoardSave2.txt', 'w') do |f1|
	    f1.puts type
	  end
	end
	
	def parse_piece(name)
	  
	end
	
	
  public
    def initialize
      @board = Hash.new(nil)
	  init_game_type
	  init_board
	  init_2D if @render_type == 2
    end

    def run
	  
    end
	
 
  end
end

chess = Chess::Board.new
