/* funcionalidad del botón hamburguesa */
$(document).ready(function () {
  $("#openM").click(function () {
    $("#menuNav").addClass("visible");
  });

  $("#exitM").click(function () {
    $("#menuNav").removeClass("visible");
  });
});

/* Código de validación del Form de Bootstrap 5 */

(function () {
  'use strict'

  var forms = document.querySelectorAll('.needs-validation')

  Array.prototype.slice.call(forms)
    .forEach(function (form) {
      form.addEventListener('submit', function (event) {
        if (!form.checkValidity()) {
          event.preventDefault()
          event.stopPropagation()
        }

        form.classList.add('was-validated')
      }, false)
    })
})()

/* Muestra o quita inputs de product */

$(document).ready(function () {

  function toggleProductInputs() {
    const value = $("#type-product").val();
    const priceOff = $('.priceoff')

    if (value === "0") {
      $(".productOff").removeClass("off");
    } else {
      $(".productOff").addClass("off");
    }
  }

 toggleProductInputs();

 $("#type-product").change(toggleProductInputs);
});





