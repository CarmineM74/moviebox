name = 'movieboxView.postersDirective'

angular.module(name,[]).directive('posters', [
  '$log'
  ($log) ->
    restrict: 'E'
    templateUrl: 'movieboxView/postersDirectiveTemplate.html'
    scope:
      search: '='
      items: '='
      itemKind: '@'
      clicked: '&'
      descrizioneClicked: '&'
])
