/* funcionalidad del botón hamburguesa */
$(document).ready(function() {
    $("#openM").click(function() {
      $("#menuNav").addClass("visible");
    });
  
    $("#exitM").click(function() {
      $("#menuNav").removeClass("visible");
    });
  });

/* Direccionamiento a Viewing al hacer click en el nombre del artículo o producto*/
$(document).ready(function() {
    $(".tdLink").click(function() {
        window.location.href = '../../viewing/viewing.html';
    });
});


/* Código de paginación de la tabla de resultados */

$(document).ready(function() {

  const rowsPerPage = 20;
  let currentPage = 1;
  const $rows = $('#table-result tbody tr');
  const numRows = $rows.length;
  const numPages = Math.ceil(numRows / rowsPerPage);

  function showPage (page) {
    const start = (page - 1) * rowsPerPage;
    const end = Math.min( start + rowsPerPage, numRows);

    $rows.hide();
    $rows.slice(start, end).show();
  }

  function updatePage () {
    $("#pagination").empty(); 

    for (let i = 1; i <= numPages; i++) { 
      let link = $("<a>").text(i).attr("href", "#").addClass("linkPage");
      if (i === currentPage) {
        link.addClass("active"); 
      }
      link.click(function(e) { 
        e.preventDefault();     
        currentPage = i;       
        showPage(currentPage); 
        updatePage();    
      });
      $("#pagination").append(link).append(" "); 
    }
  }

  showPage(currentPage);
  updatePage();
});