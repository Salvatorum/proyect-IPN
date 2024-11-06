/* Direccionamiento a Viewing al hacer click a una fila de producto o artículo*/
$(document).ready(function() {
    $("tr").click(function() {
        window.location.href = '../../viewing/viewing.html';
    });
});



       
   
    



/*

function redirigirViewing(id) {
    window.location.href = '../../viewing/viewing.html?id=' + id;
}

$(document).ready(function() {
    $("tr").click(function() {
        let id = $(this).find('td:first').text();
        redirigirViewing(id);
    });
});

*/