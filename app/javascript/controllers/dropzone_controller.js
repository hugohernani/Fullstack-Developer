import Dropzone from "dropzone";
import { createDirectUploadService, initDropZone } from '../builders';
import { Controller } from "stimulus";
import {
  getMetaValue,
  removeElement,
} from "helpers";

export default class extends Controller {
  static targets = [ "input" ]

  connect() {
    this.dropZone = initDropZone(this);
    this.hideInput();
    this.initDropzoneEvents();
    Dropzone.autoDiscover = false;
  }

  hideInput(){
    this.inputTarget.disabled = true;
    this.inputTarget.style.display = "none";
  }

  initDropzoneEvents(){
    this.dropZone.on("addedfile", file => {
      setTimeout(() => {
        file.accepted && createDirectUploadService(this, file).start();
      }, 500);
    });

    this.dropZone.on("removedfile", file => {
      file.controller && removeElement(file.controller.hiddenInput);
    });

    this.dropZone.on("canceled", file => {
      file.controller && file.controller.xhr.abort();
    });
  }

  get headers() {
    return { "X-CSRF-Token": getMetaValue("csrf-token") };
  }

  get url() {
    return this.inputTarget.getAttribute("data-direct-upload-url");
  }

  get maxFiles() {
    return this.data.get("maxFiles") || 1;
  }

  get maxFileSize() {
    return this.data.get("maxFileSize") || 256;
  }

  get acceptedFiles() {
    return this.data.get("acceptedFiles");
  }

  get addRemoveLinks() {
    return this.data.get("addRemoveLinks") || true;
  }
}
