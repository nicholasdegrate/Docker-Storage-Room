class Interface

    attr_accessor :prompt

    def initialize
        @prompt = TTY::TTY::Prompt.new
    end
end