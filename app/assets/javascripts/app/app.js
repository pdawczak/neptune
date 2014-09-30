angular
  .module('neptune', [
    'ngAnimate', 
    'ui.router', 
    'templates', 
    'angular-loading-bar',
    'ngResource',
    'directory'
  ])
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
          controller: 'BrowserCtrl',
          resolve: {
            Directory: 'Directory',
            tree: function (Directory) {
              return Directory.tree().$promise;
            }
          }
        })
        
        .state('browser.browse', {
          url: '/*path',
          resolve: {
            directoryContent: function (Directory, $stateParams) {
              return [];
            }
          },
          views: {
            'directory-breadcrumbs': {
              templateUrl: 'browser/directory/breadcrumbs.html',
              controller: 'DirectoryContentCtrl'
            },
            'directory-content': {
              templateUrl: 'browser/directory/content.html',
              controller: 'DirectoryContentCtrl'
            }
          },
          templateUrl: 'browser/directoryContent.html',
          controller: 'DirectoryContentCtrl',
        });

      $urlRouterProvider.otherwise('/dashboard');

      $locationProvider.html5Mode(true);
    }
  ]);

angular.module('directory', ['ngAnimate', 'RecursionHelper']);
