json.id directory.id.to_s
json.(directory, :name, :slug, :path)

json.children directory.children, partial: 'directory', as: :directory
