const dom = {}

dom.updateProgressHtml = ({ progress_value, bulk_upload_id }) => {
  let progressElement = document.querySelector(`#progress_bulk_upload_${bulk_upload_id} .progress-bar`);
  progressElement.style=`width: ${progress_value}%;`;
  progressElement.setAttribute('aria-valuenow', progress_value)
  progressElement.textContent = `${progress_value}%`
}

export default dom;
