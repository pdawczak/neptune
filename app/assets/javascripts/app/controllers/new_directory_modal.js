angular.module('neptune')
  .controller('NewDirectoryModalCtrl', [
    '$scope', '$modalInstance', 'Directory', 'directory',
    function ($scope, $modalInstance, Directory, directory) {
      $scope.create = function () {
        if ($scope.newDirectoryForm.$valid) {
          Directory.createChild({ directoryId: directory.id }, $scope.newDirectory, function (newDirectory) {
            $modalInstance.close(newDirectory);
          });
        }
      };
      
      $scope.cancel = function () {
        $modalInstance.dismiss('cancel');
      };
    }
 ]);
