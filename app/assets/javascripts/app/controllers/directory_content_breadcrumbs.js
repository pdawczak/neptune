angular.module('neptune')
  .controller('DirectoryContentBreadcrumbsCtrl', [
    '$scope', 'directoryBreadcrumbs',
    function ($scope, directoryBreadcrumbs) {
      $scope.directories = directoryBreadcrumbs;
    }
  ]);
