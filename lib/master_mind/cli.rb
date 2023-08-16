# frozen_string_literal: true

require "artii"

module MasterMind
  class CLI
    PROMPT_MSG = "Enter a #{Game::PATTERN_LENGTH} digit decode guess:"
    WINNING_MSG = "You WIN! You have successfully decoded the pattern"
    GAMEOVER_MSG = "Game Over! You have failed to decode the secret pattern"

    attr_reader :font

    def initialize
      @font = Artii::Base.new
    end

    def display_board(game)
      output(top_of_board)
      output(join_boards(game.boards))
      output(bottom_of_board)
    end

    def display_options
      puts "-" * 43
      puts(Game::PLAYER_TOKENS.map { |key, token| "#{key}: #{token}" }.join(" "))
    end

    def greeting
      display_launch_screen
    end

    def player_decode
      input = gets
      return nil if input.nil? || input.empty?

      to_i(input.chomp)
    end

    def prompt_for_decode
      puts PROMPT_MSG
    end

    def display_winning_msg
      puts WINNING_MSG
    end

    def display_gameover_msg
      puts GAMEOVER_MSG
    end

    private

    def join_boards(boards)
      formatted_rows = []
      decode_board, scoreboard = boards

      decode_board.length.times do |idx|
        code_row = formatted_board_row(decode_board, idx)
        key_row = formatted_board_row(scoreboard, idx)

        formatted_rows << [code_row, key_row].join(" ")
      end

      formatted_rows.join("\n")
    end

    def to_i(decode)
      return decode unless decode.is_a?(String)

      decode.chars.map(&:to_i)
    end

    def output(contents)
      puts contents
    end

    def formatted_board_row(board, row_num)
      "| #{board[row_num].join(" | ")} |"
    end

    def display_launch_screen
      puts font.asciify "MASTERMIND!!"
    end
  end
end
