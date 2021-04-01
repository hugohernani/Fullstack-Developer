$(document).ready(() => {
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
})
