module Admin
  class UsersController < BaseController
    define_action_breadcrumb_for('Users', '/admin/users')

    def index
      authorize User
      @users = User.all
    end

    def new
      authorize User
      @user = User.new
    end

    def edit
      authorize user
      user
    end

    def show
      authorize user
      user
    end

    def create
      authorize User
      @user = User.new(create_user_params)
      respond_to do |format|
        if @user.save
          format.html{ redirect_to(admin_users_path, success: t('.success')) }
        else
          format.html{ render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      authorize user
      respond_to do |format|
        if user.update(user_params)
          format.html{ redirect_to(admin_user_path(user), success: t('.success')) }
        else
          format.html{ render :edit, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      authorize User
      @user = User.destroy(params[:id])
      redirect_to admin_users_path, success: t('.success')
    end

    private

    def create_user_params
      params.require(:user).permit(:email, :full_name, :avatar_image, :role, :password)
    end

    def user_params
      params.require(:user).permit(:full_name, :role, :avatar_image)
    end

    def user
      @user ||= User.find(params[:id])
    end
  end
end
