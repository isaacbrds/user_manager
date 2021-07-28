class UsersController < ApplicationController
    before_action :set_user, only: %i[ show edit update destroy ]
    before_action :authenticate_user! , except: :create
    load_and_authorize_resource 
    #skip_authorize_resource :only => :create
  
    def index
      @users = User.all
    end
  
    def show 
      @user = User.find(params[:id])
    end
  
    def new 
      @user = User.new
    end
  
    # GET /users/1/edit
    def edit
    end
  
    # POST /users or /users.json
    def create
      @user = User.new(user_params)
  
      respond_to do |format|
        if @user.save
          format.html { redirect_to @user, notice: "User was successfully created." }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /users/1 or /users/1.json
    def update
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to @user, notice: "User was successfully updated." }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  
    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  
    def import 
      User.import(params[:file])
      ProgressBarJob.set(wait: 1.second).perform_now
      respond_to do |format|
        format.html { redirect_to users_url, notice: "The file was successfuly imported" }
        format.json { head :no_content }
      end
    end
  
    private 
  
    def set_user 
      @user = User.find(params[:id])
    end
  
     # Only allow a list of trusted parameters through.
     def user_params
      params.require(:user).permit(:full_name, :email, :role, :avatar, :password, :password_confirmation)
    end
  end