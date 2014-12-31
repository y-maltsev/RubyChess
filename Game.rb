require "./Board.rb"
require 'rubygems'
require 'gosu'

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
      until (1..3) === choise do
        puts "Chose Chess rules: 1. Standart 2. Timed rounds 3. Timed match"
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
  
  class Renderer2D < Gosu::Window
    
	def initialize(type)
	  @board = Board.new(type)
	  super 640, 480, false
      self.caption = 'Chess'
	  @board = Gosu::Image.new(self, "Media/Board.bmp", true)
	  @Br = Gosu::Image.new(self, "Media/Black_Rook.bmp", true)
	  @Bk = Gosu::Image.new(self, "Media/Black_Knight.bmp", true)
	  @Bb = Gosu::Image.new(self, "Media/Black_Bishop.bmp", true)
	  @BK = Gosu::Image.new(self, "Media/Black_King.bmp", true)
	  @BQ = Gosu::Image.new(self, "Media/Black_Queen.bmp", true)
	  @Bp = Gosu::Image.new(self, "Media/Black_Pawn.bmp", true)
	  @Wr = Gosu::Image.new(self, "Media/White_Rook.bmp", true)
	  @Wk = Gosu::Image.new(self, "Media/White_Knight.bmp", true)
	  @Wb = Gosu::Image.new(self, "Media/White_Bishop.bmp", true)
	  @WK = Gosu::Image.new(self, "Media/White_King.bmp", true)
	  @WQ = Gosu::Image.new(self, "Media/White_Queen.bmp", true)
	  @Wp = Gosu::Image.new(self, "Media/White_Pawn.bmp", true)
	  @x_offset = 140
	  @y_offset = 60
	end
	def draw
      a = i%8
      @board.draw(@x_offset, @y_offset, 0)
	  @Br.draw(@x_offset+45*a, @y_offset,0, 1, 1,  0xffffffff)
    end
	
  end
  
  class RendererCL    
	def initialize(type)
	  @board = Board.new(type)
	end

	def render_player_controls
      puts "//----------------------------------------------------------"
      puts "// to select piece/position input its coordinates, example:"
      puts "// User input: a2"
      puts "//To reset the game - User input: reset"
      puts "//To exit the game - User input: exit"
      puts "//----------------------------------------------------------"
    end
	
	def render_time  
      print "Time left = "
	  if @board.rule_type == 2
	    puts @board.turn_time.to_s 
	  else 
	    if @board.turnColor == "W"
	      puts @board.turn_time_playerW.to_s
	    else
	      puts @board.turn_time_playerB.to_s
	    end
	  end
	end
	
	def render_board
      system('cls')
      render_player_controls
      puts "  a  b  c  d  e  f  g  h"
      puts @board.board.values.map{ |x| x == nil ? x="  " : x }
       .join("|").scan(/.{1,24}/).join("\n|")
       .insert(0, "|").insert(-1, "|")
       .split("\n").each_with_index.map{ |x,i| x = (i+1).to_s+x+(i+1).to_s}.join("\n")
      puts "  a  b  c  d  e  f  g  h"
      puts "Turn: #{ @board.turnColor == "W"? "white" : "black"}"
      puts "Selected piece:#{@board.selected == nil ? "none" : "[#{(@board.selected[0]+96).chr}, #{@board.selected[1]}]"}"
      puts "possible move positions:#{@board.possible_moves == nil ? "none" : @board.possible_moves.collect{|x| [(x[0]+96).chr,x[1]] }}"
    end
	
	def handle_user_input
	    @board.update
	    render_board
		render_time if (@board.rule_type == 2 || @board.rule_type == 3)
		puts "Winner is: #{ @board.winner == "W" ? "White" : "Black"}" if(@board.winner !=nil)
        print "User Input: "
        input = gets
        until input=="reset\n" || input=="exit\n" || (@board.winner == nil && input.length-1==2 && (1..8) === input[0].ord-96 && (1..8) === input[1].to_i) do
          print "Invalid input, please re-enter input: "
          input = gets
        end
        case input
          when "reset\n" then @board.reset
          when "exit\n" then return false
          else
            @board.handle_event([input[0].ord-96,input[1].to_i])
        end
      
      true
    end
	
	def show
	  while true do
        unless handle_user_input 
		  break
		end
	  end
	end
	
  end
end

game =  Chess::Game.new
game.run
