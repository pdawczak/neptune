class DirectoriesController < ApplicationController
  def tree
    @tree = Directory.find_by name: "Root"
  end
end
