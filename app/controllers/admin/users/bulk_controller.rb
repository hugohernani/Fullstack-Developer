module Admin
  module Users
    class BulkController < Admin::BaseController
      add_breadcrumb('Users', '/admin/users')
      define_action_breadcrumb_for('Bulk', '/admin/users/bulk')

      def new
        authorize BulkUpload
        @bulk_upload = BulkUpload.new(uploader: current_user)
      end

      def show
        authorize bulk_upload
      end

      def create
        authorize BulkUpload
        @bulk_upload = current_user.bulk_uploads.new(create_bulk_upload_params)
        respond_to do |format|
          if @bulk_upload.save
            # TODO: Add a job to process the resource
            format.html{ redirect_to([:admin, :users, @bulk_upload], success: t('.success')) }
          else
            format.html{ render :new, status: :unprocessable_entity }
          end
        end
      end

      private

      def bulk_upload
        @bulk_upload ||= BulkUpload.find(params[:id])
      end

      def create_bulk_upload_params
        params.require(:bulk_upload).permit(:file)
      end
    end
  end
end
