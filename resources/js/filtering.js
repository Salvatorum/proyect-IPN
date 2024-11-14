/* funcionalidad del botón hamburguesa */
$(document).ready(function() {
    $("#openM").click(function() {
      $("#menuNav").addClass("visible");
    });
  
    $("#exitM").click(function() {
      $("#menuNav").removeClass("visible");
    });
  });


/* Direccionamiento a Viewing al hacer click a una fila de producto o artículo*/
$(document).ready(function() {
    $("tr").click(function() {
        window.location.href = '../../viewing/viewing.html';
    });
});

