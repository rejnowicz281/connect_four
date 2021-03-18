require "../lib/player.rb"
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