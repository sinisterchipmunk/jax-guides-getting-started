Jax.Controller.create "Teapot", ApplicationController,
  index: ->
    @world.addObject Teapot.find "actual"
    @world.addLightSource "sun"
    @world.addLightSource "candle"
    @world.addLightSource "searchlight"
      
  # Some special actions are fired whenever the corresponding input is
  # received from the user.
  mouse_pressed: (event) ->
