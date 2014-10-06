angular.module('neptune')
  .controller('DirectoryContentHeaderCtrl', [
    '$scope', 'currentDirectory',
    function ($scope, currentDirectory) {
      $scope.directory = currentDirectory;
    }
  ]);
