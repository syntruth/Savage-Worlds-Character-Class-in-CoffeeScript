class SWDice
  @explode = true

  constructor: (number = 1, sides = 6, mod = 0) ->
    @number = number
    @sides  = sides
    @mod    = mod

  roll: (mod = 0) ->
    how_many = @number
    result   = 0

    while how_many > 0
      num       = Math.floor Math.random() * (@sides + 1)
      result   += num
      how_many -= 1 unless @explode and num is @sides

    return result + @mod + mod

  half: () -> (@sides / 2) + (@mod / 2)
  max:  () -> (@number * @sides) + @mod

D4  = SWDice(1, 4)
D6  = SWDice(1, 6)
D8  = SWDice(1, 8)
D10 = SWDice(1, 10)
D12 = SWDice(1, 12)

WildDie        = SWDice(1, 6)
NoTrait        = SWDice(1, 4, -2)
NoTraitWildDie = SWDice(1, 6, -2)

