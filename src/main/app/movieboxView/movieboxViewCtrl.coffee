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
    $scope.itemsPerPage = 24
    $scope.currentPage = 1
    $scope.pageCount = 1
    $scope.maxPages = 20
    
    $scope.pageChanged = (page,allItems) ->
      $log.log("Changing from " + $scope.currentPage + " to " + page)
      $scope.currentPage = page
      start = (page - 1) * $scope.itemsPerPage
      stop = start + $scope.itemsPerPage - 1
      if stop > allItems.length
        stop = allItems.length - 1
      $log.log("Start: " + start + " Stop: " + stop)
      return allItems[start..stop]

    $scope.showMovies = () ->
      data.getMovies().then (resp) ->
        $scope.allMovies = resp.data
        $scope.movies = []
        $scope.pageCount = Math.floor(resp.data.length / $scope.itemsPerPage)
        if (resp.data.length % $scope.itemsPerPage) != 0
          $scope.pageCount += 1
        $scope.movies = $scope.pageChanged(1,$scope.allMovies)

    $scope.showSeries = () ->
      data.getSeries().then (resp) ->
        $scope.series = resp.data

    $scope.showMovies()
])
