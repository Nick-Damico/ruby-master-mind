# frozen_string_literal: true

module MasterMind
  class CLI
    def display_board(code_board, key_board)
      output(join_boards(code_board, key_board))
    end

    def greeting
      display_launch_screen
    end

    def player_decode
      gets.chomp
    end

    def prompt_for_decode
      puts "Enter your #{Game::PATTERN_LENGTH} digit decode guess: "
    end

    private

    def join_boards(code_board, key_board)
      formatted_rows = []
      code_board.length.times do |idx|
        code_row = formatted_board_row(code_board, idx)
        key_row = formatted_board_row(key_board, idx)

        formatted_rows << [code_row, key_row].join(" ")
      end

      formatted_rows.join("\n")
    end

    def output(contents)
      puts contents
    end

    def formatted_board_row(board, row_num)
      "| #{board[row_num].join(" | ")} |"
    end

    def display_launch_screen
      output "#" * 30
      output "WELCOME TO MASTERMIND!!"
      output "#" * 30
    end
  end
end
