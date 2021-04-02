import dom from "./bulk_uploads/dom"
import BulkUpload from './bulk_uploads/setup'

$(document).on('ready turbolinks:load', () => {
  let path_regex = /users\/bulk\/\d+/
  let pathname = window.location.pathname
  if(path_regex.exec(pathname)){
    let splitPathName = pathname.split('/')
    let bulk_id = splitPathName[splitPathName.length - 1]
    const bulkUploadsChannel = BulkUpload.setupChannel({
      bulk_upload_id: bulk_id,
      onUploadProgressUpdate: (bulkUploadData) => {
        dom.updateProgressHtml(bulkUploadData);
      }
    })
  }
})
