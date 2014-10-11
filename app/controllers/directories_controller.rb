class DirectoriesController < ApiController
  respond_to :json

  def tree
    @tree = Directory.root
  end

  def show
    @directory = Directory.find params[:id]
  end

  def create
    parent = Directory.find params[:directory_id]
    @directory = parent.children.build directory_params
    if @directory.save
      render 'show', status: 201
    else
      render json: @directory.errors, status: :unprocessable_entity
    end
  end

  def name_available
    render json: { 
      is_available: Directory.name_available?(params[:id], params[:name])
    }
  end

  private 

  def directory_params
    params.require(:directory).permit(:name)
  end
end
