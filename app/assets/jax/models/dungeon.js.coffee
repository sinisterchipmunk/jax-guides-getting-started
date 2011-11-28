parse = (str) ->
  vec = str.split /,\s*/
  return [ parseFloat(vec[0]), 0.0, parseFloat(vec[1]) ]
 
Jax.getGlobal()['Dungeon'] = Jax.Model.create
  addTorches: (world) ->
    if @map
      for z in [0...@map.length]
        row = @map[z]
        for x in [0...row.length]
          # each apostrophe (') represents a light source
          if row[x] == "'"
            torch = LightSource.find "torch"
            torch.camera.setPosition x, 0, z
            world.addLightSource torch

  after_initialize: ->
    if @starting
      @starting.position  = parse @starting.position
      @starting.direction = parse @starting.direction
      
    if map = @map
      @mesh = new Jax.Mesh
        material: "dungeon"
        init: (vertices, colors, texcoords, normals, indices) ->
          ofs = 0.5 # offset from center of each grid node
          row = null

          drawSideWall = (x, z, side) ->
            x += ofs * side
            #              triangle 1                                  triangle 2
            vertices.push  x,-ofs,z-ofs,  x,-ofs,z+ofs,  x,ofs,z-ofs,  x,ofs,z-ofs,  x,-ofs,z+ofs,  x,ofs,z+ofs
            colors.push    1,1,1,1,       1,1,1,1,       1,1,1,1,      1,1,1,1,      1,1,1,1,       1,1,1,1
            texcoords.push 0,0,           1,0,           0,1,          0,1,          1,0,           1,1
            normals.push   -side,0,0,     -side,0,0,     -side,0,0,    -side,0,0,    -side,0,0,     -side,0,0

          drawFrontWall = (x, z, side) ->
            z -= ofs*side
            #              triangle 1                                  triangle 2
            vertices.push  x-ofs,-ofs,z,  x+ofs,-ofs,z,  x-ofs,ofs,z,  x-ofs,ofs,z,  x+ofs,-ofs,z,  x+ofs,ofs,z
            colors.push    1,1,1,1,       1,1,1,1,       1,1,1,1,      1,1,1,1,      1,1,1,1,       1,1,1,1
            texcoords.push 0,0,           1,0,           0,1,          0,1,          1,0,           1,1
            normals.push   0,0,side,      0,0,side,      0,0,side,     0,0,side,     0,0,side,      0,0,side

          for y in [0...map.length]
            row = map[y]
            for x in [0...row.length]
              ch = row[x]
              if ch != 'X'
                # walls
                if x == 0            || row[x-1]    == 'X' then drawSideWall  x, y, -1   # left
                if y == 0            || map[y-1][x] == 'X' then drawFrontWall x, y,  1   # front
                if x == row.length-1 || row[x+1]    == 'X' then drawSideWall  x, y,  1   # right
                if y == map.length-1 || map[y+1][x] == 'X' then drawFrontWall x, y, -1   # back

                # floor
                vertices.push  x-0.5,-0.5,y+0.5,  x-0.5,-0.5,y-0.5,  x+0.5,-0.5,y-0.5     # tri 1
                vertices.push  x-0.5,-0.5,y+0.5,  x+0.5,-0.5,y-0.5,  x+0.5,-0.5,y+0.5     # tri 2
                colors.push    1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1
                texcoords.push 0,1,  0,0,  1,0,  0,1,  1,0,  1,1
                normals.push   0,1,0,  0,1,0,  0,1,0,  0,1,0,  0,1,0,  0,1,0

                # ceiling
                vertices.push  x-0.5,0.5,y+0.5,  x-0.5,0.5,y-0.5,  x+0.5,0.5,y-0.5        # tri 1
                vertices.push  x-0.5,0.5,y+0.5,  x+0.5,0.5,y-0.5,  x+0.5,0.5,y+0.5        # tri 2
                colors.push    1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1,  1,1,1,1
                texcoords.push 0,1,  0,0,  1,0,  0,1,  1,0,  1,1
                normals.push   0,-1,0,  0,-1,0,  0,-1,0,  0,-1,0,  0,-1,0,  0,-1,0