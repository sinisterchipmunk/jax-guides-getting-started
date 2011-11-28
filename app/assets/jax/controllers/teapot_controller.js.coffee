Jax.Controller.create "Teapot", ApplicationController,
  index: ->
    teapot = new Jax.Model
      position: [0, 0, -5]
      mesh: new Jax.Mesh.Teapot

    @world.addObject teapot
      
  # Some special actions are fired whenever the corresponding input is
  # received from the user.
  mouse_pressed: (event) ->
