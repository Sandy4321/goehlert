class AdminStats
  constructor: ->
    form = $('body.admin_stats form')

    form.on('change', '#stat_team_id', @onTeamSelectChange)

  onTeamSelectChange: (e) =>
    selectedTeamId = parseInt($(e.target).find(':selected').val())
    @autoFillTeamFields(selectedTeamId)

  autoFillTeamFields: (teamId) =>
    $.get "/teams/#{teamId}", (team) =>
      $('#stat_location').val(team.location)
      $('#stat_name').val(team.name)
      $('#stat_conference').val(team.conference)
      $('#stat_division').val(team.division)

@Goehlert ||= {}
@Goehlert.AdminStats = AdminStats
