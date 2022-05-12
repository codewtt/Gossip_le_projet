class LikesController < ApplicationController
  before_action :find_gossip
  before_action :find_like, only: [:destroy]  
  before_action :authenticate_user, only: [:create]

 
  def create
    @gossip.likes.create(user_id: current_user.id)
    redirect_to gossip_path(@gossip)
  
    
    
     if already_liked?
       flash[:notice] = "You can't like more than once"
     else
       @gossip.likes.create(user_id: @gossip.user_id)
       redirect_to gossip_path(@gossip)
     end
    
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to gossip_path(@gossip)
  end

  def find_like
    @like = @gossip.likes.find(params[:id])
 end

  private
  def find_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end
  def already_liked?
    @gossip = Gossip.find(params[:gossip_id])
    @gossip.user = current_user
    current_user_id = @gossip.user_id

    Like.where(user_id: @gossip.user_id, gossip_id: params[:gossip_id]).exists?

  end
  def authenticate_user
    unless current_user
      flash[:danger] = "Please log in."
      redirect_to new_session_path
    end
  end
end

