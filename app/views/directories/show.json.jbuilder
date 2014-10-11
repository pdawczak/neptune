json.id @directory.id.to_s
json.(@directory, :name, :path, :slug)

json.content @directory.content do |item|
  json.id item.id.to_s
  json.(item, :name, :path, :slug)
end
