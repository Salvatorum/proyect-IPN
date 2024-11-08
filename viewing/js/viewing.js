/* Permite hacer click a las imagenes del carousel y precentarlas como principales */
$(document).ready(function() {
    $('.carousel-item img').click(function() {
      var selectedImageSrc = $(this).attr('src');
      $('#selected-image').attr('src', selectedImageSrc);
    });
  });

/* seleccion de botones de colores*/  

$(document).ready(function() {

$('button').click(function(){
  $('.button').removeClass('activate');
  $(this).addClass('activate');
});


$('.button-waist').click(function(){
  $('.button-waist').removeClass('activa');
  $(this).addClass('activa');
});

});

