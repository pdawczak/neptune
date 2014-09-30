angular.module('directory')
  .factory('Directory', ['$resource',
    function ($resource) {
      return $resource('/api/directories/:directoryId', { directoryId: "@id", format: 'json' },
        {
          tree: { url: '/api/directories/tree.:format', method: 'GET' }
        }
      );
    }
  ]);
