import Dropzone from "dropzone";
import { DirectUpload } from "@rails/activestorage";
import { DirectUploadService } from '../services';

export function createDirectUploadService(source, file) {
  return new DirectUploadService(source, file);
}

export function initDropZone(controller) {
  return new Dropzone(controller.element, {
    url: controller.url,
    headers: controller.headers,
    maxFiles: controller.maxFiles,
    maxFilesize: controller.maxFileSize,
    acceptedFiles: controller.acceptedFiles,
    addRemoveLinks: controller.addRemoveLinks,
    autoQueue: false
  });
}

export function createDirectUpload(file, url, controller) {
  return new DirectUpload(file, url, controller);
}
