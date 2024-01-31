# frozen_string_literal: true

require "singleton"

module MasterMind
  class State
    include Singleton

    attr_accessor :game

    def update_state
      raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
    end

    def method_missing(method_name, *args)
      super unless method_name.end_with?("?")

      to_s == method_name[0..-2] ? true : super
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.end_with("?") || super
    end

    private

    def to_s
      class_name = self.class.name.split("::").last.downcase
      class_name.gsub("state", "")
    end
  end

  class PlayingState < State
    def update_state
      return unless game.out_of_turns? || game.won?

      game.state = GameOverState.instance
    end
  end

  class StartingState < State
    def update_state
      game.state = PlayingState.instance
    end
  end

  class GameOverState < State
    def update_state
      game.state = StartingState.instance
    end
  end
end
