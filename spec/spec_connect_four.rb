require "../lib/player.rb"

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