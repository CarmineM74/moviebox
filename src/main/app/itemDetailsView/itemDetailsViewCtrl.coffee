name = 'itemDetailsView.itemDetailsViewCtrl'

angular.module(name, []).controller(name, [
  '$scope'
  '$log'
  '$location'
  '$dialog'
  '$routeParams'
  'common.services.toastrWrapperSvc'
  'common.services.dataSvc'
  ($scope, $log, $location, $dialog, $routeParams, tstr, data) ->
    $log.log('[ItemDetailsViewCtrl] Initializing ...')
    item_id = $routeParams.id
    $scope.item_kind = $routeParams.item_kind

    $scope.items = []
    $scope.item = {}
    $scope.seasons = []

    sortProperty = (items) ->
      result = new Array(items.length)
      result[i-1] = v for i,v of items
      return result

    getDetails = (items) ->
      $scope.items = items.data
      $scope.item = item for item in $scope.items when (item.id == item_id)
      data.getItemInfo($scope.item,$scope.item_kind).success((d) =>
        $scope.details = d
        switch $scope.item_kind
          when 'movie'
            $scope.movie_link = l.link for l in d.langs when (l.lang == 'en')
          when 'serie'
            for season in [1..$scope.item.seasons]
              do (season) ->
                data.getItemInfo($scope.item,$scope.item_kind,season).success((s) =>
                  es = sortProperty(s.episodes)
                  # Recuperiamo solo gli episodi in inglese
                  for x in [0..es.length-1]
                    do (x) ->
                      if es[x]
                        es[x] = l for l in es[x] when (l.lang == 'en')
                  ts = sortProperty(s.titles)
                  ths = sortProperty(s.thumbs)
                  $scope.seasons.push({season: season, episodes: es, titles: ts, thumbs: ths})
                  $scope.seasons.sort((a,b) -> return a.season-b.season)
                )
      )

    switch $scope.item_kind
      when 'movie'
        data.getMovies().then((resp) => getDetails(resp))
      when 'serie'
        data.getSeries().then((resp) => getDetails(resp))

])

