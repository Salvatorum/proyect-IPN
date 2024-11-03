document.querySelector("header").innerHTML = `
<div class="logo">
            <img src="../resources/img/logo_iPN.svg" alt="logo">
        </div>
        <button class="openMenu bi bi-list" id="openM"></button>
        <nav class="menu" id="menuNav">   
            <ul class="menu-list">
                <button class="exitMenu bi bi-x-lg" id="exitM"></button>
                <li class="itemMenu"><a href="../filtering/filtering.html">Filtering</a></li>
                <li class="itemMenu"><a href="../viewing/viewing.html">Viewing</a></li>
                <li class="itemMenu"><a href="../modifying/modifying.html">Modifying</a></li>
                <li class="itemMenu login-text"><a href="#">Login</a></li>
            </ul> 
        </nav>
        <div class="login">
            <i class="bi bi-person-circle"></i>
        </div>
`
document.querySelector("footer").innerHTML = `
        <p>&copy; 2024 Todos los derechos reservados.</p>
`





/* funcinalidad del menú hamburguesa */
const menu = document.querySelector("#menuNav");
const openMenu = document.querySelector("#openM");
const exitMenu = document.querySelector("#exitM");

openMenu.addEventListener("click" , () => {
    menu.classList.add("visible");
});

exitMenu.addEventListener("click" , () => {
    menu.classList.remove("visible");
}) 

