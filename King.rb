module Chess
  class King
    def self.get_move_positions(source, color,  board)
	  moves = []
	  (-1..1).each do |q|
	    (-1..1).each do |p|
		  x, y = source[0]+p, source[1]+q
	      moves << [x,y] if((board[[x,y]] == nil || board[[x,y]][0] != color) && (1..8)===x && (1..8)===y)
		 end
	  end
	  moves
	end
  end
end

