class Knight
    attr_accessor :position, :moves, :parent_knight

    def initialize(position, parent_knight=nil)
        @position = position
        @moves = calc_moves(position)
        @parent_knight = parent_knight
    end

    def calc_moves(position)
        possible_moves = []
        possible_moves << [position[0]+1, position[1]+2]
        possible_moves << [position[0]+2, position[1]+1]
        possible_moves << [position[0]-1, position[1]+2]
        possible_moves << [position[0]-2, position[1]+1]
        possible_moves << [position[0]+1, position[1]-2]
        possible_moves << [position[0]+2, position[1]-1]
        possible_moves << [position[0]-1, position[1]-2]
        possible_moves << [position[0]-2, position[1]-1]

        possible_moves.filter! do |pos|
            pos[0] >= 0 && pos[0] <= 7 && pos[1] >= 0 && pos[1] <= 7
        end
        possible_moves
    end

    def display_route(start_position)
        route = []
        current_knight = self
        loop do
            route << current_knight.position
            break if current_knight.position == start_position
            current_knight = current_knight.parent_knight
        end
        route.reverse
    end
end

def knight_moves(position, destination)
    root_knight = Knight.new(position)
    queue = [root_knight]
    current_knight = nil
    loop do
        current_knight = queue[0]
        break if current_knight.position == destination
        current_knight.moves.each do |move|
          queue << Knight.new(move, current_knight)
        end
        queue.shift
    end
    route = current_knight.display_route(position)
    p route
end


knight_moves([0,0],[7,7])
