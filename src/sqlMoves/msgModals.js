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

    // 2.5sec for dissapear
    setTimeout(() => {
        msgBox.style.opacity = "0";
        setTimeout(() => {
            msgBox.style.display = "none";
        }, 500);
    }, 2500);
}




function confirmMessage(message) {
    return new Promise((resolve) => {
        const confirmBox = document.getElementById("confirmBox");
        const confirmText = document.getElementById("confirmText");
        const confirmYes = document.getElementById("confirmYes");
        const confirmNo = document.getElementById("confirmNo");

        confirmText.textContent = message;
        
        // Mostrar correctamente el modal
        confirmBox.classList.remove("hide");
        confirmBox.classList.add("show");

        // Función para cerrar el modal con animación
        function closeConfirm(result) {
            confirmBox.classList.remove("show");
            confirmBox.classList.add("hide");

            setTimeout(() => resolve(result), 300); // Resuelve la Promesa con el resultado
        }

        // Asignar eventos
        confirmYes.onclick = () => closeConfirm(true);
        confirmNo.onclick = () => closeConfirm(false);
    });
}

