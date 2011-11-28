Jax.Controller.create "Dungeon", ApplicationController,
  index: ->
    dungeon = Dungeon.find "first"
    dungeon.addTorches @world
    @world.addObject dungeon
    @player.camera.setPosition  dungeon.starting.position
    @player.camera.setDirection dungeon.starting.direction
    @player.lantern = LightSource.find "lantern"
    @world.addLightSource @player.lantern
     
  helpers: -> [ UserInputHelper ]