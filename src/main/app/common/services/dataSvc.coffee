name = 'common.services.dataSvc'

class DataSvc

	constructor: (@$log, @$http, @env) ->

	_get: (relPath)->
	  return @$http.get("#{@env.serverUrl}/#{relPath}")

  getMovies: () ->
    return @_get('data/movies_lite.json')

	getSeries: () ->
	  return @_get("data/tv_lite.json")

  getItemInfo: (item,kind,season) ->
    #@$log.log('ITEM: ' + JSON.stringify(item))
    path = ''
    switch kind
      when 'movie'
        path = 'http://trendico.ru/api/moviebox/get_movie_data?id='+item.id
      when 'serie'
        path = 'http://trendico.ru/api/moviebox/get_tv_data?id='+item.id+'&season='+season
    #@$log.log('PATH: ' + path)
    return @$http.get(path)

angular.module(name, []).factory(name, ['$log','$http', 'common.services.env', ($log, $http, env) ->
	new DataSvc($log, $http, env)
])
