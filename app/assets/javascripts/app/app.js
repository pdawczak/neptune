angular
  .module('neptune', ['ngAnimate', 'ui.router', 'templates', 'angular-loading-bar'])
  .config(['$stateProvider', '$urlRouterProvider', '$locationProvider', 
    function ($stateProvider, $urlRouterProvider, $locationProvider) {
      $stateProvider
        .state('home', {
          url: '/',
          templateUrl: 'home.html',
          controller: 'HomeCtrl'
        })
  
        .state('dashboard', {
          // abstract: true,
          url: '/dashboard',
          templateUrl: 'dashboard/layout.html'
        })
          .state('dashboard.one', {
            url: '',
            templateUrl: 'dashboard/one.html'
          })
          .state('dashboard.two', {
            url: '/two',
            templateUrl: 'dashboard/two.html',
            controller: function ($scope, $http) {
              $scope.items = [];

              $http.get('/api/directories').success(function (data) {
                $scope.items = data;
              });
            }
          })
          .state('dashboard.three', {
            url: '/three',
            templateUrl: 'dashboard/three.html'
          });

      $urlRouterProvider.otherwise('/');

      $locationProvider.html5Mode(true);
    }
  ]);
