angular.module('neptune')
  .controller('DirectoryContentCtrl', ['$scope', '$stateParams', 'Directory', 'tree',
    function ($scope, $stateParams, Directory, tree) {
      var slugs = ($stateParams.path || '').split('/'),
        previous = find_dir(tree.children, slugs.shift());
      
      $scope.directories = [tree];
      
      if (previous !== null) {
        $scope.directories.push(previous);
      }
        
      for (var i = 0, len = slugs.length; i < len; i++) {
        previous = find_dir(previous.children, slugs.shift());
        $scope.directories.push(previous);
      }

      $scope.content = [
        { name: "Sample" },
        { name: "Another" },
        { name: "Last One" },
        { name: "Just one more" },
        { name: "Testing!" },
        { name: "WhooHOoo!" },
        { name: "Dir-content" },
        { name: "Assets" },
        { name: "Previews" },
      ];
    }
  ]);

function find_dir(dirs, slug) {
  for (var i = 0, len = dirs.length; i < len; i++) {
    if (dirs[i].slug == slug) {
      return dirs[i];
    }
  }
  return null;
}
