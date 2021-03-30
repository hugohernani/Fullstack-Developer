module Admin
  class UsersController < BaseController
    def index
      @users = User.all
    end

    def new
      @user = User.new
    end

    def edit
      user
    end

    def show
      user
    end

    def create
      @user = User.new(create_user_params)
      if @user.save
        redirect_to(admin_users_path, notice: t('.success'))
      else
        render :new
      end
    end

    def update
      if user.update(user_params)
        redirect_to(admin_user_path(user), notice: t('.success'))
      else
        render :new
      end
    end

    def destroy
      @user = User.destroy(params[:id])
      redirect_to admin_users_path, notice: t('.success')
    end

    private

    def create_user_params
      params.require(:user).permit(:email, :full_name, :role, :password)
    end

    def user_params
      params.require(:user).permit(:full_name, :role)
    end

    def user
      @user ||= User.find(params[:id])
    end
  end
end
