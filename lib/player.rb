class Player

  attr_reader :token, :opp

  def initialize(token)
    @token = token
    @opp = token == "X" ? "O" : "X"
  end

end