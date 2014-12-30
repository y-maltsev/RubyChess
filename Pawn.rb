
module Chess
  class Pawn
	@@starting_pawns =[]
	
    def self.get_move_positions(source, color,  board)
	  moves = []
	  dir = color=="W"? -1:1
	  helper = [source[0], source[1]+dir]
	  if(board[helper] == nil) 
	    moves<< helper 
	    if @@starting_pawns.include?(source)
          helper2 = [source[0], source[1]+dir*2]
		  moves<< helper2 if(board[helper2] == nil  && (1..8)===helper2[1]) # in case of games like Upside-down chess a check must be made
	    end
	  end
	  helper = [source[0]+1,source[1]+dir]
	  helper2 = [source[0]-1,source[1]+dir]
	  moves << helper if(board[helper] != nil  && board[helper][0] != color)
	  moves << helper2 if(board[helper2] != nil  && board[helper2][0] != color)
	  moves
	end

	def self.add_starting_pawn(pos)
		@@starting_pawns<<pos
	end
	def self.remove_starting_pawn(pos)
		@@starting_pawns.delete(pos)
	end
  end
end