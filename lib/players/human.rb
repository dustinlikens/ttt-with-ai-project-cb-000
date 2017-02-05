module Players

  class Human < Player

    def move(board)
      puts "Please select a cell (1-9)"
      gets.chomp
    end

  end

end