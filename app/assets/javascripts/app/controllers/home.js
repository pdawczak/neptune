angular.module('neptune')
  .controller('HomeCtrl', ['$scope',
    function ($scope) {
      $scope.things = ['Angular', 'Rails 4.1', 'UI Router', 'Together!'];
    }
  ]);
