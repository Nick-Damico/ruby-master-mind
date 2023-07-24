# frozen_string_literal: true

module MasterMind
  class CLI
    PROMPT_MSG = "Enter your #{Game::PATTERN_LENGTH} digit decode guess: "

    def display_board(decode_board, scoreboard)
      output(join_boards(decode_board, scoreboard))
    end

    def greeting
      display_launch_screen
    end

    def player_decode
      gets.chomp
    end

    def prompt_for_decode
      puts PROMPT_MSG
    end

    private

    def join_boards(decode_board, scoreboard)
      formatted_rows = []
      decode_board.length.times do |idx|
        code_row = formatted_board_row(decode_board, idx)
        key_row = formatted_board_row(scoreboard, idx)

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
