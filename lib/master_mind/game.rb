# frozen_string_literal: true

module MasterMind
  class Game
    STATE = %i[start playing game_over].freeze
    def start
      greeting
    end

    def greeting
      puts "Welcome to MasterMind!"
    end
  end
end
