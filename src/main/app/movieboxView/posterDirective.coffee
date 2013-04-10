name = 'movieboxView.postersDirective'

angular.module(name,[]).directive('posters', [
  '$log'
  ($log) ->
    restrict: 'E'
    templateUrl: 'movieboxView/postersDirectiveTemplate.html'
    scope:
      items: '='
      itemKind: '@'
      clicked: '&'
])
