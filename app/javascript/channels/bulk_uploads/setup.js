import Consumer from '../consumer';

const BulkUpload = {}
export default BulkUpload

BulkUpload.setupChannel = ({ bulk_upload_id, onUploadProgressUpdate }) => {
  const onUploadProgressUpdateFn = (bulkUploadData) => {
    onUploadProgressUpdate(bulkUploadData)
  }

  let bulkUploadsChannel = Consumer.subscriptions.create({channel: "BulkUploadsChannel", upload_id: bulk_upload_id}, {
    connected: function(){
      console.debug("BulkUpload connected")
    },
    disconnected: function(){
      console.debug("BulkUpload disconnected")
    },

    received: onUploadProgressUpdateFn
  })

  return bulkUploadsChannel;
}
