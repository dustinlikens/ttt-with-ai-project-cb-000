module Players
  
  class Computer < Player

    attr_accessor :board

    WIN_COMBINATIONS = [
    [0,1,2],  # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row
    [0,3,6],  # Left column
    [1,4,7],  # Middle column
    [2,5,8],  # Right column
    [0,4,8],  # Down-right diagonal
    [2,4,6]   # Down-left diagonal
    ]

    def move(board)
      @board = board
      if board.turn_count == 0
        return "1"
        # random_move
      else
        go_for_kill || avert_loss || prevent_no_win_scenario || offense
      end 
    end 

    def go_for_kill
      # puts "go for kill"
      move = nil
      WIN_COMBINATIONS.each do |win_array|
        if win_array.count{|p|self.board.cells[p] == self.token}  == 2
          move = to_index(win_array.detect{|p|self.board.cells[p]==" "})
        end
      end
      move
    end

    def avert_loss
      # puts "avert_immediate_loss"
      move = nil
      WIN_COMBINATIONS.each do |win_array|
        if win_array.count{|p|self.board.cells[p] == self.opp} == 2
          win_array.each do |p|
            move = to_index(p) if self.board.valid_move?(to_index(p))
          end
        end
      end
      move
    end

    def prevent_no_win_scenario
      # puts "prevent no win"
      move = nil

      if self.board.turn_count == 1
        # puts "turn 1"
        # return to_index(4) if [1,3,7,9].any?{|p|p!=" "}
        # return to_index(4) if [0,2,6,8].any?{|p|self.board.cells[p]!=" "}
        return to_index(4) if self.board.valid_move?("5")
        # return to_index(8) if self.board.cells[0] == self.opp
        # return to_index(0) if self.board.cells[8] == self.opp
        # return to_index(2) if self.board.cells[6] == self.opp
        # return to_index(6) if self.board.cells[2] == self.opp
    end


      # counts = {}
      # board.cells.each_with_index do |cell, i|  
      #   count = 0
      #   if cell == " "
      #     WIN_COMBINATIONS.each do |win_array|
      #       if win_array.any?{|p|self.board.cells[p] == self.opp} && win_array.any?{|p|p == i}
      #         count += 1
      #         move = to_index(i) if count > 1
      #       end
      #     end
      #   end
      #   counts[i] = count
      # end
      # # puts counts.inspect
      # to_index(counts.sort_by{|k, v| v}.reverse[0][0])
      move
    end

    def go_for_two

    end

    def offense
      # puts "offense"
      move = nil
      2.downto(0) do |i|
        puts i
        WIN_COMBINATIONS.each do |win_array|
          # if win_array.count{|p|self.board.cells[p] == self.token}  == i  && win_array.none?{|p|self.board.cells[p] == self.opp}
          if win_array.count{|p|self.board.cells[p] != " "}  == i  && win_array.none?{|p|self.board.cells[p] == self.opp}
            # return to_index(win_array.detect{|p|self.board.cells[p] == " "})
            [0,2,1].each do |ii|
              return to_index(win_array[ii]) if self.board.valid_move?(to_index(win_array[ii]))
            end
          end
        end
      end
      random_move
      # move
    end

    def to_index(int)
      return int != nil ? (int+1).to_s : nil
    end

    def random_move
      # puts "random"
      to_index(rand(0..8))
    end

  end 
end 


