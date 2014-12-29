module Chess
  class Knight
    def self.get_move_positions(source, color,  board)
	  moves = []
	  moves+= move(source, [2,1],color,board)
	  moves+= move(source, [2,-1],color,board)
	  moves+= move(source, [-2,1],color,board)
	  moves+= move(source, [-2,-1],color,board)
	  moves+= move(source, [1,2],color,board)
	  moves+= move(source, [-1,2],color,board)
	  moves+= move(source, [1,-2],color,board)
	  moves+= move(source, [-1,-2],color,board)
	end
	
	def self.move(source,offset, color,  board)
	   moves = []
	   x, y = source[0]+offset[0], source[1]+offset[1]
	   moves << [x,y] if((1..8)===x && (1..8)===y && (board[[x,y]] == nil || board[[x,y]][0] != color))
	   moves
	end
  end
end


board = Hash.new(nil)
board[[4,4]] = "WK"
Chess::Knight.get_move_positions([4,4],"W",board)