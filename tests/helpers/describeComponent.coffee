module.exports = (name, rest) ->
  describe name, =>
    beforeEach =>
      # Load the actual React and TestUtils modules. We expect these to be the
      # actual modules, which is true if 'react/addons' is in the array of names
      # in `jest.config.unmockedModulePathPatterns`.
      @React = require('react/addons')
      {@TestUtils} = React.addons

    rest.call(@)
