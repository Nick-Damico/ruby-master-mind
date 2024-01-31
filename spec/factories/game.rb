# frozen_string_literal: true

FactoryBot.define do
  factory :game, class: "MasterMind::Game" do
    initialize_with do
      new(
        MasterMind::CLI.new,
        MasterMind::StartingState.instance
      )
    end
  end
end
