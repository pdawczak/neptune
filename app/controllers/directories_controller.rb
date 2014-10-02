class DirectoriesController < ApplicationController
  def tree
    @tree = Directory.root
  end

  def show
    @directory = Directory.find params[:id]
  end
end
