class DirectoriesController < ApiController
  def tree
    @tree = Directory.root
  end

  def show
    @directory = Directory.find params[:id]
  end

  def create
    parent = Directory.find params[:directory_id]
    @directory = parent.children.build directory_params
    @directory.save
    render 'show', status: 201
  end

  private 

  def directory_params
    params.require(:directory).permit(:name)
  end
end
