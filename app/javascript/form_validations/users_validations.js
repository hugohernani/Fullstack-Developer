$(document).ready(() => {
  let user_edit_regex = /.*users\/.*edit/;
  if(user_edit_regex.exec(window.location.pathname)){
    let user_forms = document.getElementsByClassName('needs-validation');

    validation = Array.prototype.filter.call(user_forms, (form) => {
      form.addEventListener('submit', function(event) {
        if (form.checkValidity() === false) {
          event.preventDefault();
          event.stopPropagation();
        }
        form.classList.add('was-validated');
      }, false);
    });
  }
})
