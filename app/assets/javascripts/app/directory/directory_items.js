angular.module('directory')
  .directive('directoryItems', function () {
    return {
      restrict: 'E',
      replace: true,
      scope: {
        directories: '='
      },
      templateUrl: 'browser/directory/directoryItems.html'
    };
  });
