class Player < ActiveRecord::Base
  belongs_to :team
  has_many :player_games
  has_many :games, through: :player_games


  def create_new_player(player)
    binding.pry
    new_player = Player.new(player)
    return new_player
  end

end
