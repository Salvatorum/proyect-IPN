/* Permite hacer click a las imagenes del carousel y precentarlas como principales */
$(document).ready(function() {
    $('.carousel-item img').click(function() {
      var selectedImageSrc = $(this).attr('src');
      $('#selected-image').attr('src', selectedImageSrc);
    });
  });