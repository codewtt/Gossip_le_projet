class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user, only: [:create]
  # GET /comments or /comments.json
  def index
    @comments = comment.all
    
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = comment.new  
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @comment = Comment.new(content: params[:content], gossip_id: params[:gossip_id], user_id: current_user.id)
    @comment.user = current_user
    
    
      if @comment.save 
        flash[:notice] = 'The comment were successfully uploaded'
        redirect_to gossips_url
      else
        flash[:notice] = 'The comment can not be uploaded'
        redirect_to gossip_path(params[:gossip_id])
        #redirect_to "/gossips/#{@gossip.id}"
      end
    
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    
      if @comment.update(comment_params) && @comment == current_user
        flash[:notice] = 'The comment were successfully edited'
        redirect_to gossips_url
      else
        flash[:notice] = 'The comment can not be edited'
        redirect_to gossip_path(params[:gossip_id])
      end
    
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: "comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.permit(:content, :gossip_id)
    end

    def authenticate_user
      unless current_user
        flash[:danger] = "Please log in."
        redirect_to new_session_path
      end
    end
end
