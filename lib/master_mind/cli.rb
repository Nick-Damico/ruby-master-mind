# frozen_string_literal: true

module MasterMind
  class CLI
    def greeting
      output("Welcome to MasterMind!")
    end

    def greeting
      display_launch_screen
    end

    private

    def build_board(board)
      formatted_rows =
        board.map do |row|
          "| #{row.join(" | ")} |"
        end

      formatted_rows.join("\n")
    end

    def output(contents)
      puts contents
    end

    def display_launch_screen
      output "#" * 30
      output "WELCOME TO MASTERMIND!!"
      output "#" * 30
    end
  end
end
