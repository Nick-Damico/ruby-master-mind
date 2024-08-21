# frozen_string_literal: true

require "artii"
require "cli/ui"

module MasterMind
  class CLI
    TITLE = "MASTERMIND!"
    PROMPT_MSG = "Enter a #{Game::PATTERN_LENGTH} digit decode guess:"
    WINNING_MSG = "You WIN! You have successfully decoded the pattern"
    GAMEOVER_MSG = "Game Over! You have failed to decode the secret pattern"
    BOARD_LENGTH = 20
    BOARD_SEPARATOR_LENGTH = 3

    def initialize
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

    def prompt_game_menu
      ::CLI::UI.ask("Game Menu", filter_ui: false) do |handler|
        handler.option("Start") { :playing }
      end
    end

    private

    def prompt_for_decode(game)
      game.decode_length.times.map do
        ask_for_selection(game.game_tokens)
      end
    end

    def ask_for_selection(options)
      ::CLI::UI.ask("Select your decode option:", filter_ui: false) do |handler|
        provide_options(options, handler)
      end
    end

    def provide_options(options, handler)
      options.each { |key, token| handler.option(token) { key } }
    end

    def output_divider
      puts "-" * 43
    end

    def top_of_board
      "#{"=" * BOARD_LENGTH}#{"_" * BOARD_SEPARATOR_LENGTH}#{"=" * BOARD_LENGTH}"
    end

    def bottom_of_board
      "#{"=" * BOARD_LENGTH}#{"^" * BOARD_SEPARATOR_LENGTH}#{"=" * BOARD_LENGTH}"
    end

    def join_boards(boards)
      decode, score = boards

      decode.length.times.map { |idx| format_row(decode[idx], score[idx]) }
            .join("\n")
    end

    def format_row(row1, row2)
      [formatted_board_row(row1), formatted_board_row(row2)].join(" ")
    end

    def output(contents)
      puts contents
    end

    def formatted_board_row(row)
      "| #{row.join(" | ")} |"
    end

    def display_launch_screen
      output Artii::Base.new.asciify TITLE
    end
  end
end
