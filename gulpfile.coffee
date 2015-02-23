browserify = require('browserify')
buffer = require('vinyl-buffer')
connect = require('gulp-connect')
del = require('del')
gulp = require('gulp')
jest = require('gulp-jest')
source = require('vinyl-source-stream')
sourcemaps = require('gulp-sourcemaps')
watchify = require('watchify')
require('harmonize')()


gulp.task 'default', ['clean', 'connect']

# Run local server post-build
gulp.task 'connect', ['bundle', 'static'], ->
  connect.server
    port: 3000
    root: 'dist'

# Clean dist directory
gulp.task 'clean', ->
  del ['dist']

# We want to watch our source tree and automatically rebuild upon changes.
# We'll do this using `watchify` after the following recipe:
# - https://github.com/gulpjs/gulp/blob/master/docs/recipes/browserify-uglify-sourcemap.md
gulp.task 'bundle', ->
  # Break out Browserify options for convenience
  options =
    debug: true
    entries: ['./src/index.coffee']
    extensions: ['.coffee', '.js']

  # Wrap Browserify in Watchify
  bundler = watchify(browserify(options))

  # Tell *ify about CoffeeScript
  bundler.transform('coffeeify')

  # The rest of the task is Gulp-specific, so we break it out into a function
  # that we can invoke again without also invoking the entire task.
  bundle = ->
    bundler
      .bundle()
      .on('error', console.log)
      .pipe(source('index.js'))
      .on('end', console.log)
      .pipe(buffer())
      .pipe(sourcemaps.init({loadMaps: true}))
      .pipe(sourcemaps.write('./'))
      .pipe(gulp.dest('dist'))

  # Set up listener to reinvoke non-Browserify actions on source updates
  bundler.on 'update', bundle

  bundler.on 'update', console.log
  bundler.on 'log', console.log

  # Initial invocation of non-Browserify actions
  return bundle()

# Copy static files into dist directory
gulp.task 'static', ->
  gulp
    .src('static/*')
    .pipe(gulp.dest('dist/'))

# Run tests using Jest
gulp.task 'test', ->
  options =
    collectCoverage: true
    moduleFileExtensions: [
      'js'
      'json'
      'coffee'
      'litcoffee'
      'coffee.md'
    ]
    # Process source modules from CoffeeScript if needed
    scriptPreprocessor: './preprocessor.js'
    # Configure Jasmine
    setupTestFrameworkScriptFile: './setupTestFramework.coffee'
    testDirectoryName: 'tests'
    testFileExtensions: ['coffee', 'js']
    testPathDirs: ['tests']
    testPathIgnorePatterns: ['tests/helpers']
    unmockedModulePathPatterns: [
      'jasmine-spec-reporter'
      'react'
      'react/addons'
      'tests/helpers'
    ]

  # Our `src` is `.` because Jest has its own configured notion of `rootDir`
  gulp.src('.').pipe(jest(options))
