/* funcionalidad del botón hamburguesa */
$(document).ready(function() {
    $("#openM").click(function() {
      $("#menuNav").addClass("visible");
    });
  
    $("#exitM").click(function() {
      $("#menuNav").removeClass("visible");
    });
  });


// const id = document.getElementById('id');
const form = document.getElementById('form');
const isku = document.getElementById('isku');
const nam = document.getElementById('name').value;
const price = document.getElementById('price');
const category = document.getElementById('category-option');
const categoryText = document.getElementById('category-text');
const brand = document.getElementById('brand');
const typProduct = document.getElementById('type-product');
const inUse = document.getElementById('in-use');
const stock = document.getElementById('stock');

form.addEventListener('submit', (event)=>{
    event.preventDefault();

    /* Validación del nombre*/
    if (nam.trim() === "") {
        alert("Por favor; ingrese un nombre valido");
        return;
    }
    
    alert("Formulario enviado correctamente!");
    form.submit(); // Envía el formulario

})



 