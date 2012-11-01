class UsersController < ApplicationController
  def index
    
     respond_to do |format|
      format.html
      format.json { render json: UsersDatatable.new(view_context) }
    end

    status = params[:status]
    current_user.post_to_wall(params[:status])

   
  end

  def edit
      current_user.post_to_wall(params[:status])
  end

  def post
      current_user.post_to_wall(params[:status])
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  def destroy
    
  end
  
end
