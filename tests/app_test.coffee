appPath = '../src/component/App'
jest.dontMock(appPath)

describe 'App', ->
  # Implicitly declare names that appear in `beforeEach` blocks.
  # Generic React (sub)-modules
  React = TestUtils = null

  # Names specific to the tests
  App = el = app = null

  beforeEach ->
    # Load the actual React and TestUtils modules. We expect these to be the
    # actual modules, which is true if 'react/addons' is in the array of names
    # in `jest.config.unmockedModulePathPatterns`.
    React = require('react/addons')
    {TestUtils} = React.addons

  beforeEach ->
    App = require(appPath)
    el = React.createElement App, {}
    app = TestUtils.renderIntoDocument(el)
    expect(app).toBeDefined()

  it 'contains a default greeting', ->
    h1 = TestUtils.findRenderedDOMComponentWithTag(app, 'h1')
    expect(h1).toBeDefined()
    expect(h1.getDOMNode()).toBeDefined()

  it 'has a default greeting that matches the default prop', ->
    expect(app.props.greeting).toBeDefined()
    {greeting} = app.props

    h1 = TestUtils.findRenderedDOMComponentWithTag(app, 'h1')
    {textContent} = h1.getDOMNode()
    expect(textContent).toBeDefined()
    expect(textContent).toEqual(greeting)
