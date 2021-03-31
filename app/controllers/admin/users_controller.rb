module Admin
  class UsersController < BaseController
    define_action_breadcrumb_for('Users', '/admin/users')

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
      respond_to do |format|
        if @user.save
          format.html{ redirect_to(admin_users_path, notice: t('.success')) }
        else
          format.html{ render :new, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if user.update(user_params)
          format.html{ redirect_to(admin_user_path(user), notice: t('.success')) }
        else
          format.html{ render :new, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user = User.destroy(params[:id])
      redirect_to admin_users_path, notice: t('.success')
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
