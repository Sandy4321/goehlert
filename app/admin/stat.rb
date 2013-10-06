ActiveAdmin.register Stat do
  form do |f|
    f.inputs do
      f.input :team, collection: Team.ordered, member_label: :to_s
      f.input :year
      f.input :location
      f.input :name
      f.input :conference
      f.input :division
      f.input :g_score, label: "Goehlert score"
      f.input :reg_season_rec, label: "Regular season record"
      f.input :wins
      f.input :losses
      f.input :wildcard
      f.input :playoff_app, label: "Playoff appearance"
      f.input :div_champ, label: "Division championship"
      f.input :league_champ, label: "League championship"
      f.input :champ, label: "Championship"
    end
  end
end
