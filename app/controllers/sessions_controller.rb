class SessionsController < ApplicationController
  
  def new
    #formulaire à créer
    @user = User.new
    @session == 1
    
  end

  def create
  
    # cherche s'il existe un utilisateur en base avec l’e-mail
  user = User.find_by(email: params[:email])
  
  # on vérifie si l'utilisateur existe bien ET si on arrive à l'authentifier (méthode bcrypt) avec le mot de passe
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to gossips_url
    else
      flash[:notice] = 'Invalid email/password combination'
      render 'new'
    end
    # redirige où tu veux, avec un flash ou pas
    
  end

  def destroy
    session.delete(:user_id)
    redirect_to gossips_url
  end
end
