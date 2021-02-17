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
        # potiental issue rake db:seed
       puts Player.all.map(&:name).flatten

       # returns guest to main screen    
       if $current_name == nil
            sleep(3)
            main_screen
       else
            # current user using the platform
            main_screen_login
       end
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
            while RenameCreateUser.find_by(name: name)
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
            menu.choice "see favorite players", -> {show_players} 
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
            menu.choice "see favorite players", -> {favorite_player} 
            menu.choice "add to favorite players", -> {user_sign_up}
            menu.choice "Delete favorite players", -> {user_sign_up}
            menu.choice "exit", -> { exit_helper }
        end
    end



    def exit_helper
        pp 'goodbye'
    end


    def favorite_player
        if $current_name == RenameCreateUser.find_by(name: $current_name.name)
            
        end
    end
    
end