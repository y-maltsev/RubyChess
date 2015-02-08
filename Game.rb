require "./Board.rb"
require "./Renderer2D.rb"
require "./RendererCL.rb"


module Chess
  class Game
    
    def initialize
      init_game_type
	  if @render_type == 2
        @Renderer = Renderer2D.new(@rule_type)
      else
        @Renderer = RendererCL.new(@rule_type)
      end		
    end
	
	def init_game_type
      choise = 0
      until (1..4) === choise do
        puts "Chose Chess rules: 1. Standart 2. Timed rounds 3. Timed match 4. Knight"
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
	
	def run
	  @Renderer.show
	end
  end
end


