class Board

  attr_accessor :cells

  def initialize
    @cells = []
    reset!
  end

  def reset!
    for i in 0..8
      @cells[i] = " "
    end
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end

  def position(position)
    @cells[position.to_i-1]
  end

  def full?
    @cells.none?{|c|c == " "}
  end

  def turn_count
    @cells.count{|c| c != " "}
  end

  def taken?(position)
    @cells[position.to_i-1] != " "
  end

  def valid_move?(position)
    p_int = position.to_i
    p_int.between?(1,9) && @cells[p_int-1] == " "
  end

  def update(position,player)
    @cells[position.to_i-1] = player.token
  end

end