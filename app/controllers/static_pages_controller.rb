class StaticPagesController < ApplicationController
  def team
  end

  def contact
  end

  def city
    @user = User.all
    @gossip = Gossip.all
    @city = City.all
  end
end
