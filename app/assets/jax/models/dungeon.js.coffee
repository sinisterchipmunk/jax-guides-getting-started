parse = (str) ->
  vec = str.split /,\s*/
  return [ parseFloat(vec[0]), 0.0, parseFloat(vec[1]) ]
 
Jax.getGlobal()['Dungeon'] = Jax.Model.create
  after_initialize: ->
    if @starting
      @starting.position  = parse @starting.position
      @starting.direction = parse @starting.direction