require 'minitest/autorun'
require_relative 'tic-tac-toe.rb'


#hehehe so clever
class TicTacTest < Minitest::Test

  def setup
    @game = Game.new
  end

  def test_clean_board_on_setup
    assert @game.cells.all? { |x| x = " "  }
    assert @game.continue?
  end

  def test_x_move
    @game.change_to_x(2)
    assert @game.cells[2] == "X"
    assert @game.turn == "O"
    assert @game.continue?
  end

  def test_o_move
    @game.change_to_o(2)
    assert @game.cells[2] == "O"
    assert @game.turn == "X"
    assert @game.continue?
  end

  def test_x_diagonal_win
    @game.cells = ["X"," ","O"," ","X"," ","O","O","X"]
    assert @game.x_win?
    refute @game.o_win?
    refute @game.continue?
  end

  def test_x_horizontal_win
    @game.cells = ["X","X","X","O","O"," "," "," ","O"]
    assert @game.x_win?
    refute @game.o_win?
    refute @game.continue?
  end

  def test_o_diagonal_win
    @game.cells = ["O"," ","X"," ","O"," ","X","X","O"]
    assert @game.o_win?
    refute @game.x_win?
    refute @game.continue?
  end

  def test_o_horizontal_win
    @game.cells = ["O","O","O","X","X"," "," "," ","X"]
    assert @game.o_win?
    refute @game.x_win?
    refute @game.continue?
  end

  def test_no_overwriting_cells_with_o
    @game.change_to_x(2)
    @game.change_to_o(2)
    refute @game.cells.any? {|x| x == "O"}
    assert @game.continue?
  end

  def test_no_overwriting_cells_with_x
    @game.change_to_o(2)
    @game.change_to_x(2)
    refute @game.cells.any? {|x| x == "X"}
    assert @game.continue?
  end

  def test_tie
    @game.cells = ["O","X","O","X","X","O","X","O","X"]
    refute @game.o_win?
    refute @game.x_win?
    refute @game.continue?
  end


end
