
module Chess
  class Rook
    def self.get_move_positions(source, color,  board)
	  moves = []
	  moves += move(source, source[0]-1,[-1,0],color,board)
	  moves += move(source, 8-source[0],[1,0],color,board)
	  moves += move(source, source[1]-1,[0,-1],color,board)
	  moves += move(source, 8-source[1],[0,1],color,board)
	end
	
	def self.move( source, count, dir, color, board)
	   moves = []
	   (1..count).each do |i|
	     x, y = source[0]+dir[0]*i , source[1]+dir[1]*i
	     moves << [x,y] if(board[[x,y]] == nil || board[[x,y]][0] != color)
		 break if(board[[x,y]] != nil)
	   end
	   moves 
	end
  end
end


board = Hash.new(nil)
board[[2,7]] = "Bk"
Chess::Rook.get_move_positions([2,7],"W",board)