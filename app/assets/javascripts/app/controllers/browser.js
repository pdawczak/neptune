angular.module('neptune')
  .controller('BrowserCtrl', ['$scope', '$stateParams', 'Directory', 'tree',
    function ($scope, $stateParams, Directory, tree) {
      $scope.tree = tree;
    }
  ]);
