class RenameCreateUser < ActiveRecord::Base

    has_many :players


    def main_players
        binding.pry
        self.players
    end
end