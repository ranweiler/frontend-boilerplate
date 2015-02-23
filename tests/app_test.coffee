appPath = '../src/component/App'
jest.dontMock(appPath)

# jest.dontMock('./helpers/describeComponent')
describeComponent = require('./helpers/describeComponent')

describeComponent 'App', ->
  beforeEach =>
    @App = require(appPath)
    @el = React.createElement App, {}
    @app = TestUtils.renderIntoDocument(el)
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
