# frozen_string_literal: true

require "spec_helper"

module MasterMind
  # RSpec.describe "Mastermind Game", type: :feature do
  #   subject { Game.new(CLI.new, State.new) }

  #   before(:context) do
  #     # Redirect STDOUT and STDERR to /dev/null (on Unix-based systems) or NUL (on Windows) using the with block.
  #     # Any output during the block execution will be suppressed.
  #     @original_stdout = $stdout
  #     @original_stderr = $stderr
  #     $stdout = File.new(File::NULL, "w")
  #     $stderr = File.new(File::NULL, "w")
  #   end

  #   after(:context) do
  #     # Restore the original STDOUT and STDERR after the examples are done.
  #     $stdout = @original_stdout
  #     $stderr = @original_stderr
  #   end

  #   before do
  #     # allow($stdout).to receive(:write)
  #     @pattern = [4, 3, 2, 1]
  #     subject.instance_variable_set(:@pattern, @pattern)
  #   end

  #   context "Winning Game" do
  #     it "should let a player play through to a WINNING game by successfully guessing the pattern" do
  #       stub_guesses = %w[1111 2222 3333 4444]
  #       stub_guesses << @pattern.join
  #       expected_end_of_game_turn_count = subject.current_turn - stub_guesses.size

  #       allow(subject.cli).to receive(:display_options).and_return(*stub_guesses, @pattern.join)
  #       expect(subject.pattern).to eq @pattern
  #       expect(subject.state.starting?).to eq true

  #       subject.start
  #       expect(subject.current_turn).to eq expected_end_of_game_turn_count
  #       expect(subject.state.game_over?).to eq true
  #       expect(subject.won?).to eq true
  #     end
  #   end

  #   context "Losing Game" do
  #     it "should let a player play through an entire game without successfully guessing the pattern" do
  #       wrong_guesses = 10.times.map { %w[1111 2222 3333 4444] }.flatten
  #       expected_end_of_game_turn_count = -1

  #       allow(subject.cli).to receive(:display_options).and_return(*wrong_guesses)
  #       expect(subject.pattern).to eq @pattern
  #       expect(subject.state.starting?).to eq true

  #       subject.start
  #       expect(subject.current_turn).to eq expected_end_of_game_turn_count
  #       expect(subject.state.game_over?).to eq true
  #       expect(subject.won?).to eq false
  #     end
  #   end
  # end
end
