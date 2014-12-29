module Chess
  class King
    def self.get_move_positions(source, color,  board)
	  moves = []
	  (0..2).each do |q|
	    (0..2).each do |p|
		  x, y = source[0]-1+p, source[1]-1+q
	      moves << [x,y] if(board[[x,y]] == nil || board[[x,y]][0] != color)
		 end
	  end
	  moves
	end
  end
end


board = Hash.new(nil)
board[[2,7]] = "WK"
Chess::King.get_move_positions([2,7],"W",board)