require 'pry'
class TicTacToe
    attr_accessor :board
    def initialize(board = [" "," "," "," "," "," "," "," "," "])
        @board = board
    end

    WIN_COMBINATIONS = [
        [0,1,2], # top row
        [3,4,5], # middle row
        [6,7,8], # bottom row
        [0,3,6], # first col
        [1,4,7], # second col
        [2,5,8], # third col
        [0,4,8], # diag
        [2,4,6], # diag
    ]

    def display_board
        #puts " #{@board[0]} | #{@board[1]} | #{@board[2]}\n #{@board[3]} | #{@board[4]} | #{@board[5]}\n #{@board[6]} | #{@board[7]} | #{@board[8]}\n"
        print " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        print "-----------"
        print " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        print "-----------"
        print " #{@board[6]} | #{@board[7]} | #{@board[8]} "
    end

    def input_to_index(input)
        input_integer = input.to_i
        index = input_integer-1
    end

    def move(index,token)
        @board[index] = token
    end

    def position_taken? index
        if @board[index] == " "
            false
        else
            true
        end
    end

    def valid_move? index
        if index >=0 && index <= 9 && self.position_taken?(index) == false
            true
        else
            false
        end
    end

    def turn_count
        noEmpty = @board.reject { |spot| spot == " "}
        noEmpty.length
    end

    def current_player
        if turn_count%2 == 0
            "X"
        else
            "O"
        end
    end

    def turn
        puts "What's your move? Answer between 1-9"
        input = gets.chomp
        index = input_to_index input
        valid = valid_move? index
        if valid == true
            # binding.pry
            player = current_player
            move(index,player)
            display_board
        else
            self.turn
        end
    end

    def won?
        @Xpoint=0
        @Opoint = 0
        @win_combo = []
        WIN_COMBINATIONS.each do |combo|
            combo.each do |index|
                # binding.pry
                if @board[index] == "X"
                    @Xpoint +=1
                end
                if @board[index] == "O"
                    @Opoint +=1
                end
            end
         
            if @Xpoint == 3
                @win_combo = combo
            elsif @Opoint == 3
                @win_combo = combo
            end
            # binding.pry
            @Xpoint =0
            @Opoint = 0
        end
        # binding.pry
        if @win_combo.empty?
            false
        else
            @win_combo
        end
    end

    def full?
        board_fill = @board.filter {|move| move != " "}
        if board_fill.length == 9
            true
        else
            false
        end
    end

    def draw?
        if self.won? == false && self.full? == true
            true
        else
            false
        end
    end

    def over?
        # binding.pry
        if self.won? != false || self.draw? == true
            true
        else
            false
        end
    end

    def winner
        if self.won? != false && current_player == "X"
            "O"
        elsif self.won? != false && current_player == "O"
            "X"
        else
            nil
        end
    end

    def play
        until self.over? == true
            self.turn
        end

        if self.won? != false
            puts "Congratulations #{self.winner}!"
        elsif self.draw? == true
            puts "Cat's Game!"
        end
    end
    
    
end
