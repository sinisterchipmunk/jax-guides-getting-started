Jax.Controller.create "Teapot", ApplicationController,
  index: ->
    @world.addObject Teapot.find "actual"
    @world.addLightSource "sun"
    @world.addLightSource "candle"
    @world.addLightSource "searchlight"
      
  helpers: -> [ UserInputHelper ]
