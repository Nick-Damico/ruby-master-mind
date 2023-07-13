# frozen_string_literal: true

module MasterMind
  class CLI
    def greeting
      output("Welcome to MasterMind!")
    end

    def display_board(board)
      output(build_board(board))
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
  end
end
