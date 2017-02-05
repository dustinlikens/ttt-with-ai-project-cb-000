class Game

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

  attr_accessor :board, :player_1, :player_2

  def initialize(player_1=nil,player_2=nil,board=nil)
    player_1 = Players::Human.new("X") if player_1 == nil
    player_2 = Players::Human.new("O") if player_2 == nil
    board = Board.new if board == nil

    @player_1 = player_1
    @player_2 = player_2
    @board = board
    #puts "New board init"
  end

  def current_player
    self.board.turn_count % 2 == 0 ? self.player_1: self.player_2
  end

  def over?
    won? || draw?
  end

  def won?
    ["X","O"].each do |token|
      WIN_COMBINATIONS.each do |win_combination|
        if win_combination.all? { |index| self.board.cells[index] == token }
          return win_combination 
        end
      end
    end
    false
  end

  def draw?
    self.board.cells.all?{|c|c != " "} && !won?
  end

  def winner
    won? ? self.board.cells[won?[0]] : nil
  end

  def turn
    puts "\nPlayer #{current_player.token},"
    position = current_player.move(self.board)
    if self.board.valid_move?(position)
      self.board.update(position,current_player)
      self.board.display
    else 
      turn
    end
  end

  def play
    until over?
      turn
    end
    if !draw?
    #   puts "no cat"
    #   sleep(10000)
    end
    game_over
  end

  def self.start_game
    puts "Please enter number of human players (0-2)"
    input = gets.strip
    if input == "0"
      player_1 = Players::Computer.new("X")
      player_2 = Players::Computer.new("O")
      board = Board.new
      game = Game.new(player_1,player_2,board)
      game.play
    end

    if input == "1"
      puts "Would you like to go first? (y/n)"
      response = gets.strip
      if response == "y"
        player_1 = Players::Human.new("X")
        player_2 = Players::Computer.new("O")
      else
        player_1 = Players::Computer.new("X")
        player_2 = Players::Human.new("O")
      end
      board = Board.new
      game = Game.new(player_1,player_2,board)
      game.play
    end

    if input == "2"
      player_1 = Players::Human.new("X")
      player_2 = Players::Human.new("O")
      board = Board.new
      game = Game.new(player_1,player_2,board)
      game.play
    end

    if input == "war"
      for i in 0..99
        player_1 = Players::Computer.new("X")
        player_2 = Players::Computer.new("O")
        board = Board.new
        game = Game.new(player_1,player_2,board)
        game.play
      end
    end

  end

  def game_over
    puts won? ? "~~~ Congratulations #{winner}! ~~~" : "Cat's Game! <(*ΦωΦ*)>"
    puts "Play again? (y/n)"
    self.class.start_game if gets.strip == "y"
  end



end