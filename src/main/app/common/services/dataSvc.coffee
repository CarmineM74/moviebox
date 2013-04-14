name = 'common.services.dataSvc'

class DataSvc

	constructor: (@$log, @$http, @$q, @env) ->

	_get: (relPath)->
	  return @$http.get("#{@env.serverUrl}/#{relPath}")

  _updateCats: (items,cats) =>
    for i in items 
      do (i) =>
        new_cats = []
        new_cats.push(cats[c]) for c in i.cats.split('#')
        i.cats = new_cats
    return items

  getCats: () ->
    return @_get('data/cats.json')

  getItemsWithCats: (path) ->
    deferred = @$q.defer()
    @getCats().then((cats) =>
      @_get(path).then((items) =>
        items.data = @_updateCats(items.data,cats.data)
        deferred.resolve(items)
      )
    )
    return deferred.promise

  getMovies: () ->
    return @getItemsWithCats('data/movies_lite.json')

	getSeries: () ->
    return @getItemsWithCats('data/tv_lite.json')

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

angular.module(name, []).factory(name, ['$log','$http','$q', 'common.services.env', ($log, $http, $q, env) ->
	new DataSvc($log, $http, $q,env)
])
