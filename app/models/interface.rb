class Interface

    attr_reader :prompt

    # storing current state
    $current_name = nil

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        prompt.select("Welcome to NBA Today") do |menu|
            menu.choice "See all players", -> {show_players} 
            menu.choice "Sign up or Login", -> {user_sign_up}
            menu.choice "Exit", -> { exit_helper }
        end
    end

    def show_players
        prompt.select("Choose a player") do |menu|
            Player.all.each do |p|
                menu.choice "#{p.name}", -> { players_stats(p.id) }
            end
        end
    end

    def team_stats(id)
        pp Team.find(id).name
        sleep(5)
        continue
    end

    def players_stats(id)
        new_stats = Player.find(id).stats.scan(/'(.+?)'|"(.+?)"|([^ ]+)/).flatten.compact
        
        count = 0
        
        for i in (0..new_stats.count) do
            count += 1
            if count === 2
                count = 0
                slice_it = new_stats.slice!(0,2)
                pp '- ' + slice_it.join(', ')
            end
        end

        sleep(4)
        main_screen
    end

    def user_sign_up
=begin 
    find_or_create_by(attributes, &block) public
    Finds the first record with the given attributes, or creates a record with the attributes if one is not found

    THOUGHT:
        user_sign_up could be simpified by using find_or_create_by
=end

        name = prompt.ask("what is your username?", require: true).downcase
        if RenameCreateUser.find_by(name: name)
            # assigning the state
           $current_name = RenameCreateUser.find_by(name: name)
        else
            # runs if it doesn't exist'
            while !RenameCreateUser.find_by(name: name)
                pp "Hello #{name}, re-enter name to create username:"
                name = prompt.ask("what is your username?", require: true).downcase
                break
            end
            $current_name = RenameCreateUser.create(name: name)
        end
        main_screen_login
    end 

    # guest main
    def main_screen
        system "clear"

=begin 
    user.reload
    current_name.reload

    ERROR: 
    rake aborted!
    NoMethodError: undefined method `reload' for nil:NilClass

=end

        sleep(0.5)

        prompt.select("Welcome to NBA Today") do |menu|
            # favorite players basec on current user
            menu.choice "See all players", -> {show_players} 
            menu.choice "Sign up or Login", -> {user_sign_up}
            menu.choice "Exit", -> { exit_helper }
        end
    end

    # check if the user is signed in
    def main_screen_login
        system "clear"

        sleep(0.5)

        prompt.select("Welcome to NBA Today #{$current_name.name.capitalize}") do |menu|
            # favorite players basec on current user
            menu.choice "continue NBA Today", -> {continue} 
            menu.choice "Update Account", -> {update_account}
            menu.choice "Delete Account", -> {delete_account}
            menu.choice "exit", -> { exit_helper }
        end
    end


    def update_account
        name = prompt.ask("update your name?", require: true).downcase
        $current_name.update(name: name)
        puts "Hello #{$current_name.name}"
        continue
    end

    def delete_account
        $current_name.destroy
        main_screen
    end

    def continue
        system "clear"

        sleep(0.5)

        prompt.select("Welcome to NBA Today #{$current_name.name.capitalize}") do |menu|
            # favorite players basec on current user
            menu.choice "View teams", -> {view_team_helper} 
            menu.choice "See all players", -> {show_players}
            menu.choice "Update Account", -> {update_account}
            menu.choice "exit", -> { exit_helper }
        end 
    end

    def view_team_helper
        prompt.select("Choose a Team") do |menu|
            Team.all.each do |p|
                menu.choice "#{p.name}", -> { team_stats(p.id) }
            end
        end
    end
    
    def exit_helper
        pp 'goodbye'
    end

end