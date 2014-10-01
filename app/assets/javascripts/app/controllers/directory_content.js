angular.module('neptune')
  .controller('DirectoryContentCtrl', ['$scope', '$stateParams', 'Directory', 'tree', 'directoryBreadcrumbs', 'currentDirectory',
    function ($scope, $stateParams, Directory, tree, directoryBreadcrumbs, currentDirectory) {
      $scope.directories = directoryBreadcrumbs;
      $scope.directory   = currentDirectory;
    }
  ]);
