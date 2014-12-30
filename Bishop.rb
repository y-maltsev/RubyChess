require "./Rook.rb"
module Chess
  class Bishop < Rook
    def self.get_move_positions(source, color,  board)
	  moves = []
	  moves += move(source, [8-source[0],8-source[1]].min,[1,1],color,board)
	  moves += move(source, [8-source[0],source[1]-1].min,[1,-1],color,board)
	  moves += move(source, [source[0]-1,8-source[1]].min,[-1,1],color,board)
	  moves += move(source, [source[0]-1,source[1]-1].min,[-1,-1],color,board)
	end
  end
end

board = Hash.new(nil)
board[[2,7]] = "Bk"
Chess::Bishop.get_move_positions([2,7],"W",board)