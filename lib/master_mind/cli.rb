# frozen_string_literal: true

require "artii"
require "cli/ui"

module MasterMind
  class CLI
    PROMPT_MSG = "Enter a #{Game::PATTERN_LENGTH} digit decode guess:"
    WINNING_MSG = "You WIN! You have successfully decoded the pattern"
    GAMEOVER_MSG = "Game Over! You have failed to decode the secret pattern"

    attr_reader :font

    def initialize
      @font = Artii::Base.new
      ::CLI::UI::StdoutRouter.enable
    end

    def display_board(game)
      output top_of_board
      output join_boards(game.boards)
      output bottom_of_board
    end

    def greeting
      display_launch_screen
    end

    def player_decode(game)
      output_divider
      prompt_for_decode(game)
    end

    def display_winning_msg
      puts WINNING_MSG
    end

    def display_gameover_msg
      puts GAMEOVER_MSG
    end

    private

    def prompt_for_decode(game)
      selection = []
      game.decode_length.times do
        selection << ::CLI::UI.ask("Select your decode option:", filter_ui: false) do |handler|
          game.game_tokens.each do |key, token|
            handler.option(token) { key }
          end
        end
      end
      selection
    end

    def output_divider
      puts "-" * 43
    end

    def top_of_board
      "#{"=" * 20}#{"_" * 3}#{"=" * 20}"
    end

    def bottom_of_board
      "#{"=" * 20}#{"^" * 3}#{"=" * 20}"
    end

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
