module Chess
  class Game
    def initialize
      init_game_type
      init_board
      init_2D if @render_type == 2
    end
	
	def init_game_type
      choise = 0
      until (1..3) === choise do
        puts "Chose Chess rules: 1. Standart 2. Timed 3. ???"
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
	
  end
  
  class 2Drenderer
    
	def initialize
	
	end
  end

end