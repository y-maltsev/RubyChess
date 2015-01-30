
module Chess
  class Pawn
	@@starting_pawns = []
	
    def self.get_move_positions(source, color,  board)
	  moves = []
	  dir = color=="W"? -1:1
	  move_pos1 = [source[0], source[1]+dir]
	  if(board[move_pos1] == nil) 
	    moves<< move_pos1 
	    if @@starting_pawns.include?(source)
          move_pos2 = [source[0], source[1]+dir*2]
		  moves<< move_pos2 if(board[move_pos2] == nil  && (1..8)===move_pos2[1]) # in case of games like Upside-down chess a check must be made
	    end
	  end
	  move_pos1 = [source[0] + 1, source[1] + dir]
	  move_pos2 = [source[0] - 1, source[1] + dir]
	  moves << move_pos1 if(board[move_pos1] != nil  && board[move_pos1][0] != color)
	  moves << move_pos2 if(board[move_pos2] != nil  && board[move_pos2][0] != color)
	  moves
	end
	
	def self.add_starting_pawn(pos)
		@@starting_pawns << pos
	end
	
	def self.remove_starting_pawn(pos)
		@@starting_pawns.delete(pos)
	end
	
	def self.starting_pawns
    @@starting_pawns
  end
  end
end