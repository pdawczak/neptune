angular.module('directory')
  .directive('directoryItem', function (RecursionHelper) {
    return {
      restrict: 'E',
      replace: true,
      scope: {
        directory: '='
      },
      templateUrl: 'browser/directory/directoryItem.html',
      compile: function (element) {
        return RecursionHelper.compile(element);
      }
    };
  });
