beforeEach ->
  @stub = (obj, methodName) ->
    jasmine.getEnv().currentSpec.spyOn(obj, methodName, true)
