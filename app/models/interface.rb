class Interface

    attr_reader :prompt
    attr_accessor :user, :current_name
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
       puts Player.all.map(&:name).flatten
    end

    def user_sign_up
=begin 
    find_or_create_by(attributes, &block) public
    Finds the first record with the given attributes, or creates a record with the attributes if one is not found

    THOUGHT:
        user_sign_up could be simpified by using find_or_create_by
=end

        name = prompt.ask("what is your username?").downcase
        if RenameCreateUser.find_by(name: name)
            # assigning the state
            self.current_name = RenameCreateUser.find_by(name: name)
        else
            while !RenameCreateUser.find_by(name: name)
                pp "user does not exist"
                name = prompt.ask("what is your username?").downcase
                break
            end
            self.user = RenameCreateUser.create(name: name)
            pp "Hello #{user.name}"
        end
        main_screen
    end 

    def main_screen
        system "clear"

=begin 
    user.reload
    current_name.reload

    ERROR: 
    rake aborted!
    NoMethodError: undefined method `reload' for nil:NilClass
    /Users/nicholasdegrate/Desktop/flatironschool/projects/storage-app/Ruby-CLI-Setup/app/models/interface.rb:51:in `main_screen'
    /Users/nicholasdegrate/Desktop/flatironschool/projects/storage-app/Ruby-CLI-Setup/app/models/interface.rb:46:in `user_sign_up'
    /Users/nicholasdegrate/Desktop/flatironschool/projects/storage-app/Ruby-CLI-Setup/app/models/interface.rb:12:in `block (2 levels) in welcome'
    /Users/nicholasdegrate/Desktop/flatironschool/projects/storage-app/Ruby-CLI-Setup/app/models/interface.rb:10:in `welcome'
    /Users/nicholasdegrate/Desktop/flatironschool/projects/storage-app/Ruby-CLI-Setup/app/NBATODAY.rb:17:in `welcome'
    /Users/nicholasdegrate/Desktop/flatironschool/projects/storage-app/Ruby-CLI-Setup/app/NBATODAY.rb:6:in `run'
    /Users/nicholasdegrate/Desktop/flatironschool/projects/storage-app/Ruby-CLI-Setup/Rakefile:16:in `block in <top (required)>'
    Tasks: TOP => start
    (See full trace by running task with --trace)

=end

        sleep(0.5)

        prompt.select("Welcome to NBA Today") do |menu|
            menu.choice "See all players", -> {show_players} 
            menu.choice "Sign up or Login", -> {user_sign_up}
            menu.choice "Exit", -> { exit_helper }
        end
    end

end