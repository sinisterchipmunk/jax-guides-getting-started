describe "Dungeon", ->
  model = null
  
  describe "defaults", ->
    beforeEach ->
      model = new Dungeon()
      
  
  it "should instantiate without errors", ->
    expect(-> new Dungeon()).not.toThrow()
  
  describe "'first' resource", ->
    beforeEach -> model = Dungeon.find 'first'

    it "should have a map, which should be an array of strings", ->
      expect(model.map.length).toBeGreaterThan 0
      for row in model.map
        expect(typeof row).toEqual 'string'

    it "should have a 3-element starting position", ->
      expect(model.starting.position.length).toEqual 3

    it "should have a 3-element starting direction", ->
      expect(model.starting.direction.length).toEqual 3
