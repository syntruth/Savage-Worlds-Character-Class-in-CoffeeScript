class SWCharacter
  @name          = ""
  @description   = ""
  @agility       = d4
  @smarts        = d4
  @spirit        = d4
  @strength      = d4
  @vigor         = d4
  @charism       = 0
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
  @incapacitated = false

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

  give_wound: (how_many = 1) ->
    @wounds += how_many

    if @is_wildcard
      if @wounds >= 4
        @wounds        = 4
        @incapacitated = true
    else
      if @wounds >= 1
        @wounds        = 1
        @incapacitated = true

    @shaken = true unless @incapacitated

    figure_penalty()

    return @incapacitated

  heal_wound: (how_many = 1) ->
    @wounds -= how_many

    @wounds        = 0     if @wounds < 0
    @incapacitated = false if @wounds <= 3

    figure_penalty()

    return @incapacitated

  give_fatigue: (how_many = 1) ->
    @fatigue += how_many

    if @fatigue >= 3
      @fatigue       = 3
      @incapacitated = true

    figure_penalty()

    return @incapacitated

  recover_fatigue: (how_many = 1) ->
    @fatigue -= how_many

    @fatigue       = 0    if @fatigue < 0
    @incapacitated = true if @fatigue <= 2

    figure_penalty()

    return @incapacitated

  figure_penalty: () -> @status_penalty = -@wounds + -@fatigue

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
  @agility   = d6
  @smarts    = d6
  @spirit    = d6
  @strength  = d6
  @vigor     = d6


