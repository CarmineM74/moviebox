name ='movieboxView.movieboxViewCtrl'

angular.module(name, []).controller(name, [
  '$scope'
  '$log'
  '$location'
  'common.services.toastrWrapperSvc'
  'common.services.dataSvc'
  ($scope, $log, $location, tstr, data) ->
    $log.log('[MovieBoxViewCtrl] Initializing ...')

    $scope.allMovies = []
    $scope.allSeries = []
    $scope.itemsPerPage = 24
    $scope.currentPage = 1
    $scope.pageCount = 1
    $scope.maxPages = 20

    $scope.pageChanged = (page,allItems) ->
      $scope.currentPage = page
      start = (page - 1) * $scope.itemsPerPage
      stop = start + $scope.itemsPerPage - 1
      if stop > allItems.length
        stop = allItems.length - 1
      return allItems[start..stop]

    computePages = (items) ->
      $scope.pageCount = Math.floor(items.length / $scope.itemsPerPage)
      if (items.length % $scope.itemsPerPage) != 0
        $scope.pageCount += 1

    $scope.showMovies = () ->
      data.getMovies().then (resp) ->
        $scope.allMovies = resp.data
        $scope.movies = []
        computePages(resp.data)
        $scope.movies = $scope.pageChanged(1,$scope.allMovies)

    $scope.showSeries = () ->
      data.getSeries().then (resp) ->
        $scope.allSeries = resp.data
        $scope.series = []
        computePages(resp.data)
        $scope.series = $scope.pageChanged(1,$scope.allSeries)

    $scope.itemClicked = (item,kind) ->
      #$log.log(kind + ': ' + JSON.stringify(item))
      res = data.getItemInfo(item,kind).success((d) ->
        $log.log('SUCCESS')
      ).
      error((d) ->
        $log.log('ERROR ' + JSON.stringify(d))
      )

    $scope.showMovies()
])
