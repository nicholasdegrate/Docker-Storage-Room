class Interface

    attr_reader :prompt
    attr_accessor :user

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
        name = prompt.ask("what is your username?").downcase
        while RenameCreateUser.find_by(name: name)
            if RenameCreateUser.find_by(name:name)
                break
            else

            end
            pp "This is username is already taken"
            name = prompt.ask("what is your username?").downcase
        end
        self.user = RenameCreateUser.create(name: name)
        pp "Hello #{user.name}"
        main_screen
    end 

    def main_screen
        system "clear"
        user.reload
        sleep(0.5)

        prompt.select("Welcome to NBA Today") do |menu|
            menu.choice "See all players", -> {show_players} 
            menu.choice "Sign up or Login", -> {user_sign_up}
            menu.choice "Exit", -> { exit_helper }
        end
    end

end