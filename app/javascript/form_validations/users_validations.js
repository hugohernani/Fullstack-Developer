$(document).ready(() => {
  let user_edit_regex = /.*users\/(\d*\/edit|new)/;
  let profile_edit_regex = /.*profile\/edit/;
  let current_path = window.location.pathname;
  if(user_edit_regex.exec(current_path) || profile_edit_regex.exec(current_path)){
    let user_forms = document.getElementsByClassName('needs-validation');

    validation = Array.prototype.filter.call(user_forms, (form) => {
      let isValid = false;
      form.addEventListener('submit', function(event) {
        event.preventDefault();
        event.stopPropagation();
        isValid = form.checkValidity();
        if (isValid === true) {
          form.submit()
        }else{
          form.classList.add('was-validated');
        }
      }, { catpure: true, once: isValid });
    });
  }
})
