angular.module('neptune')
  .controller('BrowserCtrl', ['$scope', 'Directory', 'tree',
    function ($scope, Directory, tree) {
      $scope.tree = tree;
    }
  ]);
