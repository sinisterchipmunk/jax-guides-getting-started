Jax.getGlobal()['Teapot'] = Jax.Model.create
  after_initialize: ->
    @mesh = new Jax.Mesh.Teapot
      size: this.size
      material: "teapot"
 
  update: (timechange) ->
    rotation_axis = [0, 1, 0]
    @camera.rotate @rotation_speed * timechange, rotation_axis
