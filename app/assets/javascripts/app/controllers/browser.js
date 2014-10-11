angular.module('neptune')
  .controller('BrowserCtrl', [
    '$scope', '$modal', 'Directory', 'tree',
    function ($scope, $modal, Directory, tree) {
      $scope.tree = tree;

      $scope.openNewDirectoryForm = function (directory) {
        var modalInstance = $modal.open({
          templateUrl: 'browser/directory/new.html',
          resolve: {
            directory: function () {
              return directory;
            }
          },
          controller: 'NewDirectoryModalCtrl'
        });

        modalInstance.result.then(function (newDirectory) {
          $scope.$broadcast('directory_created', {
            addedFor: directory,
            newDirectory: newDirectory
          });
          Directory.tree().$promise.then(function (tree) {
            $scope.tree = tree;
          });
        });
      };
    }
  ]);
