module Chess
  class Rook
    def self.get_move_positions(source, color,  board)
	  moves = []
	  ((source[0]-1).downto 1).each do |x|
	     moves << [x,source[1]] if(board[[x,source[1]]] == nil || board[[x,source[1]]][0] != color)
		 break if(board[[x,source[1]]] != nil)
	  end
	  ((source[0]+1)..8).each do |x|
	     moves << [x,source[1]] if(board[[x,source[1]]] == nil || board[[x,source[1]]][0] != color)
		 break if(board[[x,source[1]]] != nil)
	  end
	  ((source[1]-1).downto 1).each do |x|
	     moves << [source[0],x] if(board[[source[0],x]] == nil || board[[source[0],x]][0] != color)
		 break if(board[[x,source[1]]] != nil)
	  end
	  ((source[1]+1)..8).each do |x|
	     moves << [source[0],x] if(board[[source[0],x]] == nil || board[[source[0],x]][0] != color)
		 break if(board[[x,source[1]]] != nil)
	  end
	  moves
	end
  end
end



board = Hash.new(nil)
board[[2,6]] = "Bk"
Chess::Rook.get_move_positions([1,7],"W",board)