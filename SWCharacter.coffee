class SWCharacter
  @name          = ""
  @description   = ""
  @agility       = D4
  @smarts        = D4
  @spirit        = d4
  @strength      = D4
  @vigor         = D4
  @charisma      = 0
  @pace          = 6
  @parry         = 2
  @toughness     = 2
  @shaken        = false
  @wounds        = 0
  @fatigue       = 0
  @skills        = {}
  @edges         = []
  @hindrances    = []
  @is_wildcard   = false

  constructor: (options = {}) ->
    @name        = options.name
    @description = options.description

    this.set_stats      options.stats
    this.set_skills     options.skills
    this.set_edges      options.edges
    this.set_hindrances options.hindrances

  is_extra: () -> not @is_wildcard

  set_stats: (stats = {}) ->
    @agility  = stats.agility
    @smarts   = stats.smarts
    @spirit   = stats.spirit
    @strength = stats.strength
    @vigor    = stats.vigor

  set_skills:     (s = {}) -> @skills[k]     = s[k] for k in s
  set_edges:      (e = {}) -> @edges[k]      = e[k] for k in e
  set_hindrances: (h = {}) -> @hindrances[k] = h[k] for k in h

  give_wounds: (how_many = 1) ->
    @wounds += how_many

    if @is_wildcard
      @wounds = 4 if @wounds >= 4
    else
      @wounds = 1 if @wounds >= 1

    @shaken = true unless incapacitated()
    return @wounds

  heal_wounds: (how_many = 1) ->
    @wounds -= how_many
    @wounds  = 0 if @wounds < 0

  give_fatigue: (how_many = 1) ->
    @fatigue += how_many
    @fatigue  = 3 if @fatigue >= 3

    return @fatigue

  recover_fatigue: (how_many = 1) ->
    @fatigue -= how_many
    @fatigue  = 0 if @fatigue < 0

  status_penalty: () -> -@wounds + -@fatigue

  incapacitated: () ->
    return true if @wounds > 3 or @fatigue > 2
    return false

  get_trait: (name) ->
    switch name
      when "agility"  then @agility
      when "smarts"   then @smarts
      when "spirit"   then @spirit
      when "strength" then @strength
      when "vigor"    then @vigor
      else
        if @skills[name] then @skills[name] else null


class PC extends SWCharacter
  constructor: (options = {}) ->
    super options
    @player_name = options.player_name
    @is_wildcard = true

class NPC extends SWCharacter
  @agility   = D6
  @smarts    = D6
  @spirit    = D6
  @strength  = D6
  @vigor     = D6


