require "./Bishop.rb"
module Chess
  class Queen 
    def self.get_move_positions(source, color,  board)
	  moves = []
	  moves += Rook.get_move_positions(source,color,board)
	  moves += Bishop.get_move_positions(source, color,board)
	end
  end
end

board = Hash.new(nil)
board[[2,7]] = "Bk"
Chess::Queen.get_move_positions([2,7],"W",board)