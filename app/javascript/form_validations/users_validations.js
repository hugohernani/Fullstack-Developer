$(document).ready(() => {
  let user_edit_regex = /.*users\/(\d*\/edit|new)/;
  if(user_edit_regex.exec(window.location.pathname)){
    let user_forms = document.getElementsByClassName('needs-validation');

    validation = Array.prototype.filter.call(user_forms, (form) => {
      form.addEventListener('submit', function(event) {
        event.preventDefault();
        event.stopPropagation();
        if (form.checkValidity() === true) {
          form.submit()
        }else{
          form.classList.add('was-validated');          
        }
      }, { catpure: false, once: true });
    });
  }
})
