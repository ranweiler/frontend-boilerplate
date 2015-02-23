# This is where we hook into the Jest lifecycle so we can modify options for
# the underlying test framework, which is Jasmine 1.3.
# See:
# - http://facebook.github.io/jest/docs/api.html#config-setuptestframeworkscriptfile-string

# Jest doesn't currently offer the ability to directly select reporters using
# its own API. This is a pain if you want to write some sort of structured test
# output for a CI, or if you just want a reporter which is more verbose than
# the default reporter, which doesn't even list individual specs.
#
# References:
# # StackOverflow thread handling the case of Jenkins integration
# - http://stackoverflow.com/questions/25155767/jenkins-integration-with-jest
#
# # Example solution repo for the above thread, also linked-to from there
# - https://github.com/palcu/jest-example
#
# Issue opened on the Jest repo
# - https://github.com/facebook/jest/issues/104
#
# The use case of wanting to see per-spec output has been open for a while
# - https://github.com/facebook/jest/issues/4
#
# And keeps getting reopened...:
# - https://github.com/facebook/jest/pull/126
#
# ...since an old attempted wasn't merged in time, and upstream diverged
# - https://github.com/facebook/jest/pull/92
#
# There does appear to be work on a consolidated TestReporter object, at least:
# - https://github.com/facebook/jest/pull/170

# In the menatime, since Jest is built on Jasmine, we can use reporters from
# packages like `jasmine-reporters` or `jasmine-spec-reporter`. The latter is
# what this file actually does. In particular, we need to use the branch that
# compatible with Jasmine 1.3, and ~1.0.0 does the job.

SpecReporter = require('jasmine-spec-reporter')
options =
  # displayStacktrace: false     # display stacktrace for each failed assertion
  # displayFailuresSummary: true # display summary of all failures after execution
  # displaySuccessfulSpec: true  # display each successful spec
  # displayFailedSpec: true      # display each failed spec
  # displayPendingSpec: false    # display each pending spec
  # displaySpecDuration: false   # display each spec duration
  # displaySuiteNumber: false    # display each suite number (hierarchical)
  # colors:
  #   success: 'green'
  #   failure: 'red'
  #   pending: 'cyan'
  # prefixes:
  #   success: '✓ '
  #   failure: '✗ '
  #   pending: '- '
  # customProcessors: []
  displayStacktrace: true
  displaySpecDuration: true

jasmine.getEnv().addReporter(new SpecReporter(options))
