describe "Teapot", ->
  model = null
  
  describe "defaults", ->
    beforeEach ->
      model = new Teapot()
      
  
  it "should instantiate without errors", ->
    expect(-> new Teapot()).not.toThrow()
  