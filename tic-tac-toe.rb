#tic tac toe game

class Game
  attr_accessor :cells, :turn

  def initialize
    #[1-3] is row 1 [4-6] is row 2 and [7-9] is row 3
    @cells = [" "," "," "," "," "," "," "," "," "]
    @turn = "X"
  end

  def draw_board
    puts "     |     |     "
    puts "  #{@cells[0]}  |  #{@cells[1]}  |  #{@cells[2]}  "
    puts "_____|_____|_____"
    puts "     |     |     "
    puts "  #{@cells[3]}  |  #{@cells[4]}  |  #{@cells[5]}  "
    puts "_____|_____|_____"
    puts "     |     |     "
    puts "  #{@cells[6]}  |  #{@cells[7]}  |  #{@cells[8]}  "
    puts "     |     |     "
  end



   def x_win?
     x_win = [
              (@cells.values_at(0,1,2).all? {|r| r == "X"}),
              (@cells.values_at(3,4,5).all? {|r| r == "X"}),
              (@cells.values_at(6,7,8).all? {|r| r == "X"}),
              (@cells.values_at(0,3,6).all? {|r| r == "X"}),
              (@cells.values_at(1,4,5).all? {|r| r == "X"}),
              (@cells.values_at(2,5,8).all? {|r| r == "X"}),
              (@cells.values_at(0,4,8).all? {|r| r == "X"}),
              (@cells.values_at(2,4,6).all? {|r| r == "X"})
            ]
     x_win.any?
   end

   def o_win?
     o_win = [
              (@cells.values_at(0,1,2).all? {|r| r == "O"}),
              (@cells.values_at(3,4,5).all? {|r| r == "O"}),
              (@cells.values_at(6,7,8).all? {|r| r == "O"}),
              (@cells.values_at(0,3,6).all? {|r| r == "O"}),
              (@cells.values_at(1,4,5).all? {|r| r == "O"}),
              (@cells.values_at(2,5,8).all? {|r| r == "O"}),
              (@cells.values_at(0,4,8).all? {|r| r == "O"}),
              (@cells.values_at(2,4,6).all? {|r| r == "O"})
            ]
     o_win.any?
   end

    def change_to_x(spot)
      if @cells[spot] == " "
        @cells[spot] = "X"
        @turn = "O"
      end
    end

    def change_to_o(spot)
      if @cells[spot] == " "
        @cells[spot] = "O"
        @turn = "X"
      end
    end

   def end_game
     self.draw_board
     if self.x_win?
       puts "X won thanks for playing!"
       exit
     elsif self.o_win?
       puts "O won thanks for playing!"
       exit
     else
       puts "looks like a tie"
       exit
     end
   end

   def continue?
     if !self.x_win? && !self.o_win? && !self.cells.none? { |r| r == " "}
       true
     else
       false
     end
   end


   def play
     puts "Welcome to tic tac toe"
     while continue?
       self.draw_board
       if self.turn == "X"
         puts "it is X's turn, what square?"
         square = gets.chomp.to_i
         self.change_to_x(square)
       elsif self.turn == "O"
         puts "it is O's turn, what square?"
         square = gets.chomp.to_i
         self.change_to_o(square)
       end
     end
     self.end_game
   end

end
