React = require('react/addons')
{h1} = React.DOM
{createClass} = React

# Router = require('react-router')

# DefaultRoute = Router.DefaultRoute
# Link = Router.Link
# Route = Router.Route
# RouteHandler = Router.RouteHandler

# {DefaultRoute, Link, Route, RouteHandler} = Router

App = createClass
  # getInitialState: -> {}

  getDefaultProps: ->
    greeting: 'hello, world'

  # onClick: (event) ->

  render: ->
    (h1 {}, @props.greeting)


module.exports = App
