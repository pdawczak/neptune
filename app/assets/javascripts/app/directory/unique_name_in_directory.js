angular.module('directory')
  .directive('uniqueNameInDirectory', [
    '$http',
    function ($http) {
      return {
        require: 'ngModel',
        link: function (scope, element, attrs, ctrl) {
          ctrl.processing = false;
          scope.$watch(attrs.ngModel, function (n) {
            if (! n) {
              ctrl.$setValidity('unique', true);
              return;
            }
            if (! scope.directory) {
              console.error('Directory not specified in scope!');
              return;
            }
            ctrl.processing = true;
            $http({
              method: 'POST',
              url: '/api/directories/' + scope.directory.id + '/name_available',
              data: { name: n },
              ignoreLoadingBar: true
            }).success(function (data) {
              ctrl.$setValidity('unique', data.is_available);
              ctrl.processing = false;
            }).error(function (data) {
              ctrl.$setValidity('unique', false);
              ctrl.processing = false;
            });
          });
        }
      };
    }
  ]);
