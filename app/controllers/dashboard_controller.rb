class DashboardController < ApplicationController
  before_action :get_users 
  before_action :authenticate_user! 
  def index
    
  end

  def index_admin 
    
  end

  def index_client
    
  end

  private
  def get_users
    @users = User.all 
    @users_admin = User.where(role: :admin)
    @users_client = User.where(role: :client)
  end
end
