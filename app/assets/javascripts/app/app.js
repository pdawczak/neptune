angular
  .module('neptune', ['ngAnimate', 'ui.router', 'templates', 'angular-loading-bar'])
  .config(['$stateProvider', '$urlRouterProvider', '$locationProvider', 
    function ($stateProvider, $urlRouterProvider, $locationProvider) {
      $stateProvider
        .state('dashboard', {
          url: '/dashboard',
          templateUrl: 'dashboard/dashboard.html',
          controller: 'DashboardCtrl'
        })

        .state('browser', {
          url: '/browse',
          templateUrl: 'browser/browser.html',
          controller: 'BrowserCtrl'
        });

      $urlRouterProvider.otherwise('/dashboard');

      $locationProvider.html5Mode(true);
    }
  ]);
