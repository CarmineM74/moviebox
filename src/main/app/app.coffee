### ###########################################################################
# Wire modules together
### ###########################################################################

mods = [

  'ui'
  'ui.bootstrap'
	'common.directives.glowGreenOnMouseoverDirective'
	'common.filters.toLowerFilter'
	'common.services.dataSvc'
	'common.services.envProvider'
	'common.services.toastrWrapperSvc'

  'movieboxView.movieboxViewCtrl'

	'index.indexCtrl'

]

### ###########################################################################
# Declare routes 
### ###########################################################################

routesConfigFn = ($routeProvider) ->
  $routeProvider.when('/main',
    {templateUrl: 'movieboxView/movieboxView.html'})

  $routeProvider.otherwise({redirectTo: '/main'})

### ###########################################################################
# Create and bootstrap app module
### ###########################################################################
	
m = angular.module('app', mods)

m.config ['$routeProvider', routesConfigFn]
m.config (['common.services.envProvider', (envProvider)->

	# Allows the environment provider to run whatever config block it wants.
	if envProvider.appConfig?
		envProvider.appConfig()
])

m.run (['common.services.env', (env)->

	# Allows the environment service to run whatever app run block it wants.
	if env.appRun?
		env.appRun()
])

angular.element(document).ready ()->
	angular.bootstrap(document,['app'])
