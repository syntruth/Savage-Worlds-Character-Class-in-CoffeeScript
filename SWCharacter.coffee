class Character
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

  set_stats: (stats = {}) ->
    @agility  = stats.agility
    @smarts   = stats.smarts
    @spirit   = stats.spirit
    @strength = stats.strength
    @vigor    = stats.vigor

  set_skills:     (s = {}) -> @skills[k]     = s[k] for k in s
  set_edges:      (e = {}) -> @edges[k]      = e[k] for k in e
  set_hindrances: (h = {}) -> @hindrances[k] = h[k] for k in h

  take_wound: (how_many = 1) ->
    @wounds += how_many

    if @wounds >= 4
      @wounds        = 4
      @incapacitated = true

    return @incapacitated

  heal_wound: (how_many = 1) ->
    @wounds -= how_many

    @wounds        = 0     if @wounds < 0
    @incapacitated = false if @wounds <= 3

    return @incapacitated

class PC extends Character
  constructor: (options = {}) ->
    super options
    @player_name = options.player_name
    @is_wildcard = true

class NPC extends Character
  @agility   = d6
  @smarts    = d6
  @spirit    = d6
  @strength  = d6
  @vigor     = d6


