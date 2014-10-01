class DirectoriesController < ApplicationController
  def tree
    @tree = Directory.find_by name: "Root"
  end

  def show
    @directory = Directory.find params[:id]
  end
end
