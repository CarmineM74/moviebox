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
  'movieboxView.postersDirective'
  'itemDetailsView.itemDetailsViewCtrl'

	'index.indexCtrl'

]

### ###########################################################################
# Declare routes 
### ###########################################################################

routesConfigFn = ($routeProvider) ->
  $routeProvider.when('/main',
    {templateUrl: 'movieboxView/movieboxView.html'})
  $routeProvider.when('/details/:id/kind/:item_kind',
    {templateUrl: 'itemDetailsView/itemDetailsView.html'})
  $routeProvider.otherwise({redirectTo: '/main'})

### ###########################################################################
# Create and bootstrap app module
### ###########################################################################
	
m = angular.module('app', mods)

m.config (['$httpProvider', (httpProvider) ->
  httpProvider.defaults.headers.common["X-Requested-With"] = undefined
  httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
])

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
