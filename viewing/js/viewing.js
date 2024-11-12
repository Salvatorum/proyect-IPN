/* Permite hacer click a las imagenes del carousel y precentarlas como principales */
$(document).ready(function() {
    $('.carouselItem img').click(function() {
      var selectedImageSrc = $(this).attr('src');
      $('#selectedImage').attr('src', selectedImageSrc);
    });
  });

/* seleccion de botones de colores*/  

$(document).ready(function() {

$('button').click(function(){
  $('.button').removeClass('activate');
  $(this).addClass('activate');
});


$('.buttonWaist').click(function(){
  $('.buttonWaist').removeClass('activa');
  $(this).addClass('activa');
});

});

