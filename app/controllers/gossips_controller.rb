class GossipsController < ApplicationController
  before_action :set_gossip, only: %i[ show edit update destroy ]
  before_action :authenticate_user, only: [:new, :create, :show]
  
  # GET :: Gossip
  def index
    @gossips = Gossip.all
  end

   # GET :: /gossips/new
  def new
    @gossip = Gossip.new
  end

  # POST :: /gossips
  def create
    @gossip = Gossip.new(gossip_params)
    @gossip.user = current_user
      if @gossip.save && @gossip.user = User.find_by(id: session[:user_id])
        flash[:notice] = 'The gossip were successfully created'
        redirect_to gossips_url
      else
        flash[:notice] = 'The gossip can not be created, it is not completed'
        redirect_to gossip_path(params[:id])
      end
  end

  # GET /gossips/1 or /gossips/1.json
  def show
    @comments = Comment.all
    @user = User.all
    current_user = @gossip.user
  end

  # GET /gossips/1/edit
  def edit
    @gossip = Gossip.find(params[:id])
  end

  # PATCH/PUT /gossips/1 or /gossips/1.json
  def update
    if @gossip.user_id == current_user.id
      if @gossip.update(gossip_params) 
        flash[:notice] = 'The gossip were successfully updated'
        redirect_to gossips_url
      else
        flash[:notice] = 'The gossip can not be updated, you are not the author of this gossip'
        redirect_to gossip_path(params[:id])
      end
    else
      flash[:notice] = 'The gossip can not be updated, you are not the author of this comment'
      redirect_to gossip_path(params[:id])
    end
  end

  # DELETE :: /gossips/
  def destroy
    if @gossip.user_id == current_user.id
      if @gossip.destroy 
        flash[:notice] = 'The gossip were successfully deleted'
        redirect_to gossips_url
      else
        flash[:notice] = 'The gossip can not be deleted, you are not the author of this gossip'
        redirect_to gossips_url
      end
    else
      flash[:notice] = 'The gossip can not be deleted, you are not the author of this comment'
      redirect_to gossips_url
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gossip
      @gossip = Gossip.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def gossip_params
      params.require(:gossip).permit(:title, :content, :user_id)
    end

    def authenticate_user
      unless current_user
        flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end
end
