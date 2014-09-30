json.id @tree.id.to_s
json.(@tree, :name, :path, :slug)

json.children @tree.children, partial: 'directory', as: :directory
