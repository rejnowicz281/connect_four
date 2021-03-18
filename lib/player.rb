class Player 
    attr_reader :name, :disc_colour
    attr_accessor :disc, :moves

    def initialize(name, disc_colour)
        @name = name
        @disc_colour = disc_colour
        @disc = colorized_disc("#{disc_colour}")
        @moves = []
    end
    
    def colorized_disc(colour)
        colour_ids = { red: 31, blue: 34, yellow: 33, black: 30 }
        colour_id = colour_ids[colour.to_sym]
        "\e[#{colour_id}m\u26ab\e[0m"
    end 
end