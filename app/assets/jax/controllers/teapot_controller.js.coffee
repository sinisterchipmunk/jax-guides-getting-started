Jax.Controller.create "Teapot", ApplicationController,
  index: ->
    @world.addObject Teapot.find "actual"
    @world.addLightSource "sun"
    @world.addLightSource "candle"
    @world.addLightSource "searchlight"
      
  mouse_dragged: (event) ->
    @player.camera.pitch 0.01 *  event.diffy
    @player.camera.yaw   0.01 * -event.diffx