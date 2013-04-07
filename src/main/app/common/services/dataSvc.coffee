name = 'common.services.dataSvc'

class DataSvc

	constructor: (@$log, @$http, @env) ->

	_get: (relPath)->
		return @$http.get("#{@env.serverUrl}/#{relPath}")

	getMovies: () ->
	  return @_get('data/movies_lite.json')

	getSeries: () ->
		return @_get("data/tv_lite.json")

angular.module(name, []).factory(name, ['$log','$http', 'common.services.env', ($log, $http, env) ->
	new DataSvc($log, $http, env)
])
