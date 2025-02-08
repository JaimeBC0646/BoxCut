const { remote } = require('electron');
const main = remote.require('./main.js');


const txtIdentity = document.getElementById('txtIdentity');
const txtPassword = document.getElementById('txtPassword');
const btnLogin = document.getElementById('btnLogin');

btnLogin.addEventListener('click', async (err)=>{
    err.preventDefault();
    //console.log(txtIdentity.value+' '+txtPassword.value)
    identity = txtIdentity.value;
    password = txtPassword.value;
    
    const uSesion = await main.loginQuery(identity, password);


    if (result.length > 0) {
        // Podrías almacenar el tipo de usuario en el almacenamiento local
        //localStorage.setItem('userSession', uSesion);

        window.location.href = './accessAdmin/adminMenu.html';
    }
})

