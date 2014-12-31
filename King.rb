module Chess
  class King
    def self.get_move_positions(source, color,  board)
	  moves = []
	  (0..2).each do |q|
	    (0..2).each do |p|
		  x, y = source[0]-1+p, source[1]-1+q
	      moves << [x,y] if((board[[x,y]] == nil || board[[x,y]][0] != color) && (1..8)===x && (1..8)===y)
		 end
	  end
	  moves
	end
  end
end

