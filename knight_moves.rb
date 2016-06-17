#custom class behaves like array, but pushes to the front
#to simulate a queue
class MyQueue < Array
	def push elem
		self.unshift elem
	end
end

class Baord
	def initialize
		@max_x = 7
		@max_y = 7
	end

	#returns true if the piece is on the board, false otherwise
	def on_board? piece
		piece.x <= @max_x && piece.y <= @max_y
	end
end

class Knight
	attr_reader :x, :y, :history, :position
	def initialize( position, history = [] ) # position is [x,y]
		@x = position[0]
		@y = position[1]
		@position = position
		@history = history + [ position ]
	end

	#returns an array of knight objects at each of the 8 possible spots to go
	#note: this list does not exlude moves off the board
	def next_moves
		moves = [ [ @x + 2, @y + 1 ], [ @x + 2, @y - 1 ], [ @x + 1, @y + 2 ],
						 [ @x + 1, @y - 2 ], [ @x - 1, @y + 2 ], [ @x - 1, @y - 2 ],
						 [ @x - 2, @y + 1 ], [ @x - 2, @y -1 ] ]
		moves.map { |move| Knight.new(move, @history) }
	end
end

#return the path with the least steps to get from start to stop
#using valid knight moves and not going off the board
def knight_moves(start, stop)
	queue = MyQueue.new
	board = Baord.new
	knight = Knight.new(start)
	queue.push knight
	until knight.position == stop || queue.empty?
		knight = queue.pop
		#validate the moves (so they are on the board)
		valid_moves = knight.next_moves.select { |move| board.on_board? move }
		valid_moves.each { |move| queue.push move }
	end
	knight.history #return all the steps it took to find the position
end

def show_moves(start, stop)
	move_list = knight_moves( start, stop )
	puts "It took #{move_list.length - 1} moves! Here are the steps:"
	move_list.each { |move| puts move.inspect }
end

show_moves([6,2],[1,1])
show_moves([0,0],[7,7])