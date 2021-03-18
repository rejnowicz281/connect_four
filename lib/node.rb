class Node
    attr_reader :id
    attr_accessor :disc, :win_cords_list

    def initialize(id)
        @id = id 
        @win_cords_list = nil
        @disc = "  "
    end 
end 