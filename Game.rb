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
	  @models = Hash.new(nil)
	  @models["board"] = Gosu::Image.new(self, "Media/Board.bmp", true)
	  @models["selector"] = Gosu::Image.new(self, "Media/Selector.bmp", true)
	  @models["moves"] = Gosu::Image.new(self, "Media/Moves.bmp", true)
	  @models["Br"] = Gosu::Image.new(self, "Media/Black_Rook.bmp", true)
	  @models["Bk"] = Gosu::Image.new(self, "Media/Black_Knight.bmp", true)
	  @models["Bb"] = Gosu::Image.new(self, "Media/Black_Bishop.bmp", true)
	  @models["BK"] = Gosu::Image.new(self, "Media/Black_King.bmp", true)
	  @models["BQ"] = Gosu::Image.new(self, "Media/Black_Queen.bmp", true)
	  @models["BP"] = Gosu::Image.new(self, "Media/Black_Pawn.bmp", true)
	  @models["Bp"] = Gosu::Image.new(self, "Media/Black_Pawn.bmp", true)
	  @models["Wr"] = Gosu::Image.new(self, "Media/White_Rook.bmp", true)
	  @models["Wk"] = Gosu::Image.new(self, "Media/White_Knight.bmp", true)
	  @models["Wb"] = Gosu::Image.new(self, "Media/White_Bishop.bmp", true)
	  @models["WK"] = Gosu::Image.new(self, "Media/White_King.bmp", true)
	  @models["WQ"] = Gosu::Image.new(self, "Media/White_Queen.bmp", true)
	  @models["Wp"] = Gosu::Image.new(self, "Media/White_Pawn.bmp", true)
	  @models["WP"] = Gosu::Image.new(self, "Media/White_Pawn.bmp", true)
	  @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
	  @x_offset = 140
	  @y_offset = 60
	  @selector = [1,1]
	  @x=10
	  @y=10
	end
	
	def update
	  puts  "selected before = #{@board.selected.inspect}"
	  if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
        @x = @x-1
      end
	  if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
        @x = @x+1
      end
      if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
        @y = @y-1
      end
      if button_down? Gosu::KbDown or button_down? Gosu::GpButton0 then
        @y = @y+1
      end
	  if button_down? Gosu::KbSpace then
        @board.reset
      end
	  if button_down? Gosu::KbReturn then
	   # puts "selector_before = #{@selector.inspect} selected before = #{@board.selected.inspect}"
        @board.handle_event([@selector[0],@selector[1]])
      end
	  @x=10 if @x<10
	  @x=80 if @x>80
	  @y=10 if @y<10
	  @y=80 if @y>80
	  @selector[0]=@x/10
	  @selector[1]=@y/10
	  @board.update
	end
	
	def draw
      @models["board"].draw(@x_offset, @y_offset, 0)
	  @board.possible_moves.each{ |x| @models["moves"].draw(@x_offset+45*(x[0]-1), @y_offset+45*(x[1]-1),0)} if @board.possible_moves != nil
	  @models["selector"].draw(@x_offset+45*(@selector[0]-1), @y_offset+45*(@selector[1]-1),0)
	  (1..8).each do |y|
	    (1..8).each do |x|
		  @models[@board.board[[x,y]]].draw(@x_offset+45*(x-1), @y_offset+45*(y-1),0) if @board.board[[x,y]] != nil
		end
	  end
	  draw_time  if (@board.rule_type == 2 || @board.rule_type == 3)
    end
	
	def draw_time
	  @font.draw("Time left: #{ 
	  if @board.rule_type == 2
	    @board.turn_time.to_i.to_s 
	  else 
	    if @board.turnColor == "W"
	       @board.turn_time_playerW.to_i.to_s
	    else
	       @board.turn_time_playerB.to_i.to_s
	    end
	  end
	  }", 10, 10, 1, 1.0, 1.0, 0xffffff00)
	end
	def button_down(id)
      if id == Gosu::KbEscape
	    @board.save_board
        close
    end
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
	  @board.save_board
	end
	
  end
end

game =  Chess::Game.new
game.run
