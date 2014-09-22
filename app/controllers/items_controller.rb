class ItemsController < ApplicationController
  def directories
    sleep(2)
    @items = ['/dir1', '/dir1/dir2', '/dir1/dir2/dir3']
    render json: @items
  end
end
