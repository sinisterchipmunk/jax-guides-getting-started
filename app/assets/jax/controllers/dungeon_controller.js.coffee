Jax.Controller.create "Dungeon", ApplicationController,
  index: ->
    dungeon = Dungeon.find "first"
    @world.addObject dungeon
    @player.camera.setPosition  dungeon.starting.position
    @player.camera.setDirection dungeon.starting.direction
 
  helpers: -> [ UserInputHelper ]