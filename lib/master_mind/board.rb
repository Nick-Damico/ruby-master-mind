module MasterMind
  class Board
    attr_accessor :decode, :key

    def initialize(rounds, guesses_per_round)
      @rounds = rounds
      @guesses = guesses_per_round
      @decode = generate_decode
      @key = generate_key
    private

    def generate_decode
      Array.new(@rounds) { Array.new(@guesses, "🔘") }
    end

    def generate_key
      Array.new(@rounds) { Array.new(@guesses, "🔘") }
    end
  end
