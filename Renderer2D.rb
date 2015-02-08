require 'rubygems'
require 'gosu'

module Chess
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
	  @x = @x - 1 if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft
	  @x = @x + 1 if button_down? Gosu::KbRight or button_down? Gosu::GpRight
      @y = @y - 1 if button_down? Gosu::KbUp or button_down? Gosu::GpButton0
      @y = @y + 1 if button_down? Gosu::KbDown or button_down? Gosu::GpButton0
	  @board.reset if button_down? Gosu::KbSpace
	  @board.handle_event([@selector[0],@selector[1]]) if button_down? Gosu::KbReturn
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
	  draw_winner if(@board.winner !=nil)
	  draw_time  if (@board.rule_type == 2 || @board.rule_type == 3)
    end
	
	def draw_winner
	  @font.draw("Winner is: #{ @board.winner == "W" ? "White" : "Black" }", 10, 100, 1, 1.0, 1.0, 0xffffff00)
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
end