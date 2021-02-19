require 'faker'
require_relative '../app/models/request_api'

Team.destroy_all
Player.destroy_all
PlayerGame.destroy_all
Game.destroy_all
RenameCreateUser.destroy_all
Team.reset_pk_sequence
Player.reset_pk_sequence
PlayerGame.reset_pk_sequence
Game.reset_pk_sequence
RenameCreateUser.reset_pk_sequence

Faker::UniqueGenerator.clear

=begin 
    REQUEST FOR THE API
        FETCH: players, players info, teams
=end
stats = RequestApi.request_api('stats')
=begin 
    create random users

    DONE
=end
70.times do
    RenameCreateUser.create(
        name: Faker::Name.unique.name
    )
end



def random_user
    random_user_id = rand(1..RenameCreateUser.all.count)
    RenameCreateUser.find(random_user_id).id
end

=begin 
    creating players

    DONE
=end
stats.map { |hash|
    user_id = random_user

    # some players don't have a position
    position_not_found = if hash['player']['position'] == '' then 'not found' else hash['player']['position'] end

    Player.create(
        name: "#{hash['player']['first_name']} #{hash['player']['last_name']}",
        position: position_not_found,
        team_id: hash['team']['id'],
        user_id: user_id,
        stats: "ast #{hash['ast']} pts #{hash['pts']} reb #{hash['reb']} stl #{hash['stl']} weight #{hash['player']['weight_pounds']} position #{hash['player']['position']} team #{hash['team']['full_name']}"
    )
}

=begin 

    creating the teams

    DONE
=end

stats.map { |hash|
    Team.create(
        name: hash["team"]["full_name"],
        team_year: Time.now.strftime("%Y")
    )
}
=begin 

=end

stats.map { |hash| 

    PlayerGame.create(
        points: hash['game']['home_team_score'].to_i + hash['game']['visitor_team_score'].to_i,
        player_id: hash['player']['id'],
        wins: hash['game']['home_team_score'].to_i,
        losses: hash['game']['visitor_team_score'].to_i, 
    )
}

stats.map { |hash|
    win_or_lost = if hash['game']['home_team_score'].to_i < hash['game']['visitor_team_score'].to_i then false else true end

    Game.create( 
        win_or_lost: win_or_lost
    )
}


puts "🔥 🔥 🔥 🔥 "