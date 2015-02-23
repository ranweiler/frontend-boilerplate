React = require('react/addons')
{createFactory, render} = React

App = createFactory require('./component/App')

body = document.getElementsByTagName('body')[0]
render (App {}), body
