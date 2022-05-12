class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  
  # GET /users or /users.json
  def index
    @users = User.all
    City.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @city = City.all
    @city_name = City.all.name
    @city_id = City.all.ids
    
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    
      if @user.save
        flash[:notice] = 'Bienvenue parmi les gossipers !!'
        redirect_to gossips_url
      else
        flash[:notice] = 'The gossip can not be updated, you are not the author of this gossip'
        render :new
                    
      end
    
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
  
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:first_name, :last_name, :age, :description,:city_id, :email, :password)
    end



end
