FactoryGirl.define do
  factory :team do
    league { 'mlb' }
    conference { 'Test Conference' }
    division { 'Test Division' }
    sequence(:name) { |i| "Team #{i}" }
    sequence(:abbr) { |i| "T#{i}" }
    location { 'Somewhere, USA' }

    factory :mlb_team do
      league { 'mlb' }
    end

    factory :nba_team do
      league { 'nba' }
    end

    factory :nhl_team do
      league { 'nhl' }
    end

    factory :nfl_team do
      league { 'nfl' }
    end
  end
end
