FactoryGirl.define do
  factory :stat do
    year { Time.now }
    wins { 10 }
    losses { 10 }
    reg_season_rec { 0.5 }
    wildcard { 0 }
    playoff_app { 1 }
    div_champ { 0 }
    league_champ { 0 }
    champ { 0 }
    g_score { rand 15 }

    team
  end
end
