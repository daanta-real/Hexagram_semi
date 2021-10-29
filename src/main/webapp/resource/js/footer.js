var hamburgerInput = document.createElement("input");
hamburgerInput.id = "mobileMenuHamburgerInput";
hamburgerInput.type = "checkbox";
var hamburgerBox = document.getElementById("hamburgerBox");
document.getElementById("mobileMenuLayer").insertBefore(hamburgerInput, hamburgerBox);