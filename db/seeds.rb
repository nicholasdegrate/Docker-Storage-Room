require 'faker'
require_relative '../config/.api'

Team.destroy_all
Player.destroy_all
PlayerGame.destroy_all
Game.destroy_all
Team.reset_pk_sequence
Player.reset_pk_sequence
PlayerGame.reset_pk_sequence
Game.reset_pk_sequence


Faker::UniqueGenerator.clear


50.times do
    RenameCreateUser.create(
        name: Faker::Name.unique.name
    )
end

30.times do
    Team.create(
        name:Faker::Sports::Basketball.unique.team,
        team_year: Time.now.strftime("%Y")
    )
end

def request_api(subject)
    url = URI("https://free-nba.p.rapidapi.com/#{subject}?page=0&per_page=50")


    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    request = Net::HTTP::Get.new(url)

    request["x-rapidapi-key"] = $api_key
    request["x-rapidapi-host"] = $api_url

    response = http.request(request)
    parsed = JSON.parse(response.read_body)
    
    parsed['data'].map { |hash| hash}
end

players = request_api('players')

players.map { |hash|
    Player.create(
        name: hash['first_name'],
        position: hash['position'],
        team_id: hash['team']['id'],
        user_id: rand(1..50)
    )
}

5.times do

    rand_points =rand(5..45)
    rand_player_id = rand(1..3)
    rand_wins = rand(0..1)
    rand_losses = rand(0..1)
    
    PlayerGame.create(
        points: rand_points,
        player_id: rand_player_id,
        wins: rand_wins,
        game_id: 1,
        losses: rand_losses
    )
end

30.times do

    Game.create(
        win_or_lost: false,
        player_id: rand(1..10),
        player_game_id: rand(1..5)
    )
end

# 481.times do
#     rand_jersey = rand(1..99)
#     rand_shoes = rand(8..16)
    
#     Player.create(
#         name: Faker::Sports::Basketball.unique.player,
#         jersey_number: rand_jersey,
#         shoe_size: rand_shoes,
#         dob: 2000,
#         championship: nil,
#         team_id:     
#     )
# end

































# # THIS SEED FILE NEEDS TO BE ENTIRELY REPLACED -- I'M LEAVING CODE FOR YOUR REFERENCE ONLY!

# Plant.destroy_all
# Person.destroy_all
# PlantParenthood.destroy_all
# Plant.reset_pk_sequence
# Person.reset_pk_sequence
# PlantParenthood.reset_pk_sequence

# ########### different ways to write your seeds ############

# # 1: save everything to variables (makes it easy to connect models, best for when you want to be intentional about your seeds)
# basil = Plant.create(name: "basil the herb", bought: 20200610, color: "green")
# sylwia = Person.create(name: "Sylwia", free_time: "none", age: 30)
# pp1 = PlantParenthood.create(plant_id: basil.id, person_id: sylwia.id, affection: 1_000_000, favorite?: true)

# # 2. Mass create -- in order to connect them later IN SEEDS (not through the app) you'll need to find their id
# ## a. by passing an array of hashes:
# Plant.create([
#     {name: "Corn Tree", bought: 20170203, color: "green"},
#     {name: "Prayer plant", bought: 20190815, color: "purple"},
#     {name: "Cactus", bought: 20200110, color: "ugly green"}
# ])
# ## b. by interating over an array of hashes:
# plants = [{name: "Elephant bush", bought: 20180908, color: "green"},
#     {name: "Photos", bought: 20170910, color: "green"},
#     {name: "Dragon tree", bought: 20170910, color: "green"},
#     {name: "Snake plant", bought: 20170910, color: "dark green"},
#     {name: "polka dot plant", bought: 20170915, color: "pink and green"},
#     {name: "Cactus", bought: 20200517, color: "green"}]

# plants.each{ |hash| Plant.create(hash)}

# # 3. Use Faker and mass create
# ## step 1: write a method that creates a person
# def create_person
#     free = ["mornings", "evenings", "always", "afternoons", "weekends", "none"].sample

#     person = Person.create(
#         name: Faker::Movies::HitchhikersGuideToTheGalaxy.character,
#         free_time: free,
#         age: rand(11...70)
#     )
# end

# ## step 2: write a method that creates a joiner
# def create_joiners(person)
#     plants_number = rand(1..4)
#     plants_number.times do 
#         PlantParenthood.create(
#             plant_id: Plant.all.sample.id, 
#             person_id: person.id, 
#             affection: rand(101), 
#             favorite?: [true, false].sample
#         )
#     end
# end

# ## step 3: invoke creating joiners by passing in an instance of a person
# 10.times do     
#     create_joiners(create_person)
#     ##### ALTERNATIVE:
#     # person = create_person
#     # create_joiners(person)
# end

# indoor = Category.create(name: "indoors")

# Plant.update(category_id: indoor.id)


puts "🔥 🔥 🔥 🔥 "