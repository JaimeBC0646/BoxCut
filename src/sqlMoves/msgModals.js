function showMessage(message, type = "success", subMessage = "") {
    const msgBox = document.getElementById("msgBox");
    const msgText = document.getElementById("msgText");
    const msgSubtext = document.getElementById("msgSubtext");

    // Set color (depends of bool variable)
    msgBox.style.backgroundColor = type === "error" ? "#dc3545" : "#28a745";

    // Set messages
    msgText.textContent = message;
    msgSubtext.textContent = subMessage; // Mensaje adicional

    // Show messages
    msgBox.style.display = "block";
    msgBox.style.opacity = "1";

    // 3sec for dissapear
    setTimeout(() => {
        msgBox.style.opacity = "0";
        setTimeout(() => {
            msgBox.style.display = "none";
        }, 500);
    }, 2500);
}





function confirmMessage(message, callback) {
    const confirmBox = document.getElementById("confirmBox");
    const confirmText = document.getElementById("confirmText");
    const confirmYes = document.getElementById("confirmYes");
    const confirmNo = document.getElementById("confirmNo");

    confirmText.textContent = message;
    
    // Mostrar correctamente el modal (reseteamos cualquier estilo previo)
    confirmBox.classList.remove("hide");
    confirmBox.classList.add("show");

    // Función para cerrar el modal con animación
    function closeConfirm(result) {
        confirmBox.classList.remove("show");
        confirmBox.classList.add("hide");

        setTimeout(() => {
            callback(result);
        }, 300); // Espera que termine la animación antes de ejecutar la función
    }

    // Botón "Yes"
    confirmYes.onclick = () => closeConfirm(true);

    // Botón "Cancel"
    confirmNo.onclick = () => closeConfirm(false);
}
