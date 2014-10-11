angular.module('neptune')
  .controller('DirectoryContentCtrl', [
    '$scope', 'currentDirectory',
    function ($scope, currentDirectory) {
      $scope.directory = currentDirectory;

      $scope.$on('directory_created', function (eventName, eventData) {
        if ($scope.directory.id == eventData.addedFor.id) {
          $scope.directory.content.push(eventData.newDirectory);
        }
      });
    }
  ]);
