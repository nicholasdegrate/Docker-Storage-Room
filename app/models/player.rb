class Player < ActiveRecord::Base
  belongs_to :team
  belongs_to :rename_create_user
  has_many :player_games
  has_many :games, through: :player_games

end
