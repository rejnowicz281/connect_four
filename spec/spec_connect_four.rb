require "../lib/player.rb"
require "../lib/game.rb"
require "../lib/board.rb"

describe Player do 
    describe "#colorized_disc" do 
        context "when given colour red" do
            subject(:player) { described_class.new("player1", "red") } 
            it "returns red disc" do 
                player_colour = player.disc_colour
                expect(subject.colorized_disc(player_colour)).to eq("\e[31m\u26ab\e[0m")
            end 
        end     
    end 
end 

describe Board do 
    describe "#get_node" do 
        subject(:board) { described_class.new }
        context "when given id [0,0]" do
            it "returns the node with id [0,0]" do 
                id = [0,0]
                node = board.get_node(id)
                expect(node.id).to eq(id)
            end 
        end
    end 

    describe "#get_win_cords_list" do 
        context "when given id 0 and 0" do 
            it "returns [[[0, 1], [0, 2], [0, 3]], [[1, 0], [2, 0], [3, 0]], [[1, 1], [2, 2], [3, 3]]]" do 
                id0 = 0 
                id1 = 0
                cords_list = [[[0, 1], [0, 2], [0, 3]], [[1, 0], [2, 0], [3, 0]], [[1, 1], [2, 2], [3, 3]]]

                get_win_cords_list = subject.get_win_cords_list(id0, id1)
                
                expect(get_win_cords_list).to eq(cords_list)
            end 
        end 
    end 

    describe "#win_cords_off_board?" do 
        context "when given win_cords [ [0, -1], [0, -2], [0, -3] ]" do 
            it "returns true" do
                win_cords = [ [0, -1], [0, -2], [0, -3] ]
                is_off_board = subject.win_cords_off_board?(win_cords)
                expect(is_off_board).to be(true)
            end 
        end 
        
        context "when given win cords [ [0, 1], [0, 2], [0, 3] ]" do 
            it "returns false" do 
                win_cords = [ [0, 1], [0, 2], [0, 3] ]
                is_off_board = subject.win_cords_off_board?(win_cords)
                expect(is_off_board).to be(false)
            end 
        end 
    end 
end 

describe ConnectFour do 
    describe "#names_or_discs_conflict?" do 
        context "when names or discs conflict" do
            it "returns true" do 
                dbl = double("conflict")
                allow(dbl).to receive(:new).with(Player.new("player", "red"), Player.new("player", "blue"))
                allow(dbl).to receive(:names_or_discs_conflict?)
                expect(dbl).to receive(:names_or_discs_conflict?).and_return(true)
                dbl.names_or_discs_conflict?
            end     
        end 

        context "when names or discs do not conflict" do
            it "returns false" do 
                dbl = double("no_conflict")
                allow(dbl).to receive(:new).with(Player.new("player1", "red"), Player.new("player2", "blue"))
                allow(dbl).to receive(:names_or_discs_conflict?)
                expect(dbl).to receive(:names_or_discs_conflict?).and_return(false)
                dbl.names_or_discs_conflict?
            end     
        end 
    end 

    describe "#choose_disc_colour" do 
        context "when chosen colour is not available" do 
            subject(:choice) { described_class.new(Player.new("player1", "red"), Player.new("player2", "blue")) }
            it "puts out error message" do
                error_message = "\nThe colour you typed in is unavailable\n\n"
                allow(choice).to receive(:loop).and_yield
                allow(choice).to receive(:input_colour).and_return("invalid_color")
                expect{choice.choose_disc_colour}.to output(error_message).to_stdout
            end 
        end 
    end 

    describe "#random_player" do 
        subject(:game) { described_class.new(Player.new("player1", "red"), Player.new("player2", "blue")) }
        it "returns random player" do 
            random_id = 1
            random_player = game.random_player(random_id)
            expect(random_player).to be(game.player1)
        end 
    end 

    describe "#other_player" do 
        subject(:game) { described_class.new(Player.new("player1", "red"), Player.new("player2", "blue")) }
        context "when given player is player1" do 
            it "returns player2" do 
                given_player = game.player1
                player2 = game.player2
                other_player = game.other_player(given_player)
                expect(other_player).to be(player2)
            end 
        end 

        context "when given player is player2" do 
            it "returns player1" do 
                given_player = game.player2
                player1 = game.player1
                other_player = game.other_player(given_player)
                expect(other_player).to be(player1)
            end 
        end 
    end 

    describe "#win?" do 
        subject(:game) { described_class.new(Player.new("player1", "red"), Player.new("player2", "blue")) }
        context "if player moves are in the winning coordinates of a node" do 
            it "returns true" do 
                player_moves = [ [0,0], [0,1], [0,2], [0,3] ]
                node = game.board.get_node([0,3])
                win = game.win?(player_moves, node) 
                expect(win).to be true
            end 
        end 

        context "if player moves are not in the winning coordinates of a node" do 
            it "returns false" do 
                player_moves = [ [0,0], [0,1] ]
                node = game.board.get_node([0,1])
                win = game.win?(player_moves, node) 
                expect(win).to be false
            end 
        end 
    end
end 