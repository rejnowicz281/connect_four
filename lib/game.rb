require_relative "board.rb"
require_relative "player.rb"

class ConnectFour 
    DISC_COLOURS = ["red", "blue", "yellow", "black"]

    attr_reader :board, :player1, :player2
    def initialize(player1 = initialize_player("1"), player2 = initialize_player("2"))
        @board = Board.new
        @player1 = player1 
        @player2 = player2

        if names_or_discs_conflict? || !(colour_available?(player1.disc_colour)) || !(colour_available?(player2.disc_colour))
            @player1 = nil 
            @player2 = nil
            puts "\nSomething went wrong."
            initialize
        end
    end 

    def names_or_discs_conflict?
        player1.name == player2.name || player1.disc_colour == player2.disc_colour
    end 

    def colour_available?(colour)
        DISC_COLOURS.include?(colour)
    end 

    def initialize_player(player_id)
        puts "\nNote: Two players can't have the same name/discs";puts
        puts "Player#{player_id}: "
        name = input_name 
        colour = choose_disc_colour
        Player.new(name, colour)
    end

    def input_name
        puts "Type in a name: "
        gets.chomp
    end 

    def choose_disc_colour 
        loop do 
            colour = input_colour 
            verified_colour = verify_colour(colour)
            if verified_colour == colour
                return colour
            else    
                puts "\nThe colour you typed in is unavailable";puts
            end 
        end
    end 

    def input_colour
        puts "Type in a colour(available colors: #{DISC_COLOURS.join(" | ")}): "
        gets.chomp
    end 

    def verify_colour(colour)
        if colour_available?(colour)
            colour
        else
            nil
        end 
    end 

    def random_player(rand_num = rand(1..2))
        rand_num == 1 ? player1 : player2
    end 

    def play(player = random_player)
        puts "Starting player is #{player.name}"
        player_turn(player)
    end 

    def input_column
        puts "Where we dropping?(0-#{board.m-1})"
        gets.chomp
    end 

    def player_turn(player) 
        board.show_board(true)
        puts "#{player.name} | #{player.disc}" 
        column = input_column.to_i

        if column < 0 || column > board.n
            puts "Invalid column id"
            player_turn(player)
        elsif board.column_full?(column) 
            puts "Can't update column #{column}, it is full"
            player_turn(player)
        else
            updated_node = board.update_column(column, player.disc)
            player.moves << [updated_node.id[0], updated_node.id[1]]
            if win?(player.moves, updated_node)
                board.show_board(true)
                puts "\n\n"
                puts "#{player.name}#{player.disc} wins!"
            else
                player_turn(other_player(player))
            end 
        end 
    end 

    def other_player(player) 
        player == player1 ? player2 : player1
    end 

    def win?(player_moves, node) 
        node.win_cords_list.each do |win_cords|
            include_count = 0
            win_cords.each do |win_cord|
                if player_moves.include?(win_cord) 
                    include_count += 1
                end 
                if include_count == 3
                    return true
                end 
            end 
        end 

        false
    end 
end     

g = ConnectFour.new 

g.play