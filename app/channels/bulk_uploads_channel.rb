class BulkUploadsChannel < ApplicationCable::Channel
  def subscribed
    stream_for BulkUpload.find(params[:upload_id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
