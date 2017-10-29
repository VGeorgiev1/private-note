class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    user = User.new({username: params[:username], password: params[:password], email: params[:email]});
    user.save
    session[:logedUser] = user.id
    render "success"
  end
  def loginGet
    render "login"
  end
  def loginPost
    @user = User.find_by username: params[:username];
    if @user!=nil
      if @user.password==params[:password]
        session[:logedUser] = @user.id
        render "success"
      else
        @error='Incorect password or username!';
        render "login"
      end
    else
      @error='Incorect password or username!';
      render "login"
    end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
end
