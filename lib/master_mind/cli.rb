# frozen_string_literal: true

module MasterMind
  class CLI
    def greeting
      output("Welcome to MasterMind!")
    end
    private
    def output(contents)
      puts contents
    end
  end
end
