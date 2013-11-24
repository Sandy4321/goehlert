require 'spec_helper'

feature 'filtering compiled stats by league' do
  before do
    @mlb_team = create :mlb_team
    @nhl_team = create :nhl_team
    @nba_team = create :nba_team

    @mlb_stat = create :stat, team: @mlb_team, g_score: 5
    @nhl_stat = create :stat, team: @nhl_team, g_score: 5
    @nba_stat = create :stat, team: @nba_team, g_score: 5

    visit '/stats'
  end

  it 'shows stats from all leagues by default' do
    fill_in 'result_count', with: 5
    select 'Goehlert Score', from: 'measured_stat'
    select "#{Time.now.year}", from: 'start_year'
    select "#{Time.now.year}", from: 'end_year'

    within '.league-filter' do
      check 'MLB'
      check 'NHL'
      check 'NBA'
    end

    click_on 'Submit'

    [@mlb_team, @nhl_team, @nba_team].each do |team|
      expect(page).to have_content team.name
    end
  end

  it 'shows no stats when no leagues are selected' do
    fill_in 'result_count', with: 5
    select 'Goehlert Score', from: 'measured_stat'
    select "#{Time.now.year}", from: 'start_year'
    select "#{Time.now.year}", from: 'end_year'

    within '.league-filter' do
      uncheck 'MLB'
      uncheck 'NHL'
      uncheck 'NBA'
    end

    click_on 'Submit'

    [@mlb_team, @nhl_team, @nba_team].each do |team|
      expect(page).to_not have_content team.name
    end
  end

  it 'shows stats for teams in selected leagues' do
    new_mlb_team = create :mlb_team

    @mlb_stat.update_attributes(g_score: 8)
    @nhl_stat.update_attributes(g_score: 8)
    new_mlb_stat_1 = create :stat, team: new_mlb_team, g_score: 7

    fill_in 'result_count', with: 2
    select 'Goehlert Score', from: 'measured_stat'
    select "#{Time.now.year}", from: 'start_year'
    select "#{Time.now.year}", from: 'end_year'

    within '.league-filter' do
      check 'MLB'
      uncheck 'NHL'
      uncheck 'NBA'
    end

    click_on 'Submit'

    expect(page).to have_content @mlb_team.name
    expect(page).to have_content new_mlb_team.name

    expect(page).to_not have_content @nhl_team.name
  end
end
