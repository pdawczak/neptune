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
      $urlRouterProvider.when('/browse', '/browse/');
      $urlRouterProvider.otherwise('/dashboard');

      $locationProvider.html5Mode(true);

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
            directoryBreadcrumbs: function ($state, $stateParams, tree) {
              var slugs = ($stateParams.path || '').split('/').filter(function (slug) { return slug != ''; }),
                previous = tree,
                directories = [previous];
                
              for (var i = 0, len = slugs.length; i < len; i++) {
                previous = find_dir(previous.children, slugs.shift());
                if (previous == null) {
                  $state.go('browser.browse', { path: '' });
                }
                directories.push(previous);
              }

              return directories;
            },
            currentDirectory: function (Directory, directoryBreadcrumbs) {
              var dir = directoryBreadcrumbs[directoryBreadcrumbs.length - 1];
              return Directory.get({ directoryId: dir.id }).$promise;
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
    }
  ]);

angular.module('directory', ['ngAnimate', 'RecursionHelper']);

function find_dir(dirs, slug) {
  for (var i = 0, len = dirs.length; i < len; i++) {
    if (dirs[i].slug == slug) {
      return dirs[i];
    }
  }
  return null;
}
