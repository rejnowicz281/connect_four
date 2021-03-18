require_relative "node.rb"

class Board 
    attr_reader :n, :m, :nodes
    def initialize(n = 6, m = 7) # create n x m board
        @n = n
        @m = m
        @nodes = get_nodes
    end

    def get_nodes 
        nodes = []
        x = 0
        y = 0
        until nodes.length == n*m 
            node = Node.new([x,y])
            node.win_cords_list = get_win_cords_list(node.id[0], node.id[1])
            nodes << node
            y += 1
            if y == m
                x += 1       # push in nodes with proper coordinates
                y = 0
            end 
        end 
        nodes
    end 

    def get_win_cords_list(id0, id1)
        win_cords_list_model = [ [ [0,-1],[0,-2],[0,-3] ], [ [0,1],[0,2],[0,3] ], [ [1,0],[2,0],[3,0] ], [ [-1,0],[-2,0],[-3,0] ], 
                               [ [-1,-1],[-2,-2],[-3,-3] ], [ [-1,1],[-2,2],[-3,3] ], [ [1,1],[2,2],[3,3] ], [ [1,-1],[2,-2],[3,-3] ] ]

        win_cords_list = []

        win_cords_list_model.each do |win_cords_model| 
            win_cords = []
            win_cords_model.each do |win_cord_model|
                new_id0 = id0 + win_cord_model[0]
                new_id1 = id1 + win_cord_model[1]
                win_cords << [new_id0, new_id1] 
            end
            win_cords_list << win_cords unless win_cords_off_board?(win_cords)
        end 

        win_cords_list
    end 

    def win_cords_off_board?(win_cords)
        off_board = false 
        win_cords.each do |win_cord| 
            if win_cord[0] < 0 || win_cord[0] > n-1 || win_cord[1] < 0 || win_cord[1] > m - 1
                off_board = true
                break
            end 
        end 
        off_board
    end 

    def show_board(show_ids = false)
        nodes.each do |node|
            if show_ids
                print "[#{node.id[0]} #{node.disc}#{node.id[1]}]"
            else
                print "[ #{node.disc}]"
            end  
            puts if node.id[1] == m-1
        end 
    end 

    def get_node(id) 
        nodes.each { |node| return node if node.id == id }
    end 

    def update_column(column, disc, y = n-1, node = get_node([y, column]))
        if column_full?(column)
            return
        elsif node.disc == "  "
            node.disc = disc 
            node
        elsif node.disc != "  "
            update_column(column, disc, y - 1)
        end 
    end 

    def column_full?(column, y = n-1, node = get_node([y, column]))
        if y == -1 
            true 
        elsif node.disc == "  "
            false 
        else
            column_full?(column, y - 1)
        end 
    end
end