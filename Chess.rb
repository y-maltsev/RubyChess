module Chess
  class Board
  private
    attr_accessor :board, :rule_type, :render_type
	
	def init_game_type
	  choise = 0
	  until (1..3) === choise do
	    puts "Chose Chess rules: 1. Standart 2. timed 3. ???"
		choise = gets.to_i
	  end
	  @rule_type = choise
	  choise = 0
	  until (1..2) === choise do
	    puts "Chose Chess Render type: 1. Command Line 2. 2D"
		choise = gets.to_i
	  end
	  @render_type = choise
	end
	
	def init_board
	  File.open('BoardSave.txt', 'r') do |f1|  
	    (1..8).each do |y|
	      f1.gets.split.each_with_index{ |piece, x | @board[[x+1,y]] = (piece == "n")? nil:piece}		  
	    end
	  end
	end
  public
    def initialize
      @board = Hash.new(nil)
	  init_game_type
	  init_board
    end

    def run
	  
    end
	
 
  end
end
