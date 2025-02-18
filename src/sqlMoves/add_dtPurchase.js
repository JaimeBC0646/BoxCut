const newDtPurchaseDiv = document.getElementById('newDtPurchaseDiv');

const { remote } = require('electron');
const { escape } = require('promise-mysql');
const main = remote.require('./main.js');


/* CHARGING FORM */
function chargeForm() {
    charge_branchstores();
    charge_revelances();
}

let branchstores = [];
/* Charge data: Branchstore  -|START|- */
const charge_branchstores = async () => {
    branchstores = await main.getBranchstores();
    //console.log(branchstores)

    if (branchstores) {
        branchstores.sort();   // Order A-Z
        addOptions("txt_store", branchstores);
    }

    // Add options into <select>
    function addOptions(domElement, branchstores) {
        var select = document.getElementsByName(domElement)[0];
        //console.log(branchstores[0].vchName);

        for (value in branchstores) {
            var option = document.createElement("option");
            option.value = branchstores[value].idBranchstore;
            option.text = branchstores[value].vchName;
            select.add(option);
        }
    }
}
/* Charge data: Branchstore  -|END|- */


/* Charge data: Relevance  -|START|- */
const charge_revelances = async () => {
    let revelances = [];
    revelances = await main.getRelevances();
    //console.log(revelances)

    if (revelances) {
        revelances.sort();   // Order A-Z
        addOptions("txt_relevance", revelances);
    }

    // Add options into <select>
    function addOptions(domElement, revelances) {
        var select = document.getElementsByName(domElement)[0];
        //console.log(revelances[0].vchName);

        for (value in revelances) {
            var option = document.createElement("option");
            option.value = revelances[value].idRelevance;
            option.text = revelances[value].vchDescription;
            select.add(option);
        }
    }
}
/* Charge data: Relevance  -|END|- */



/* Form: newDtPurchaseDiv  -|START|- */
var dateFilter;
const datePurchase_filter = document.getElementById('dtP_Input');
const btnPurchase = document.getElementById('btn_addPurchase');
const btncancel = document.getElementById('btnCancel');

var id_P = 0;
datePurchase_filter.addEventListener('change', async (err) => {
    dateFilter = datePurchase_filter.value
    //await query_IdP(dateFilter);

    if (dateFilter != null) {
        datePurchase_filter.disabled = true;
        btnPurchase.disabled = false;
        btncancel.removeAttribute("hidden");
        console.log(id_P);
    }
    console.log(dateFilter)
})


function dtRestart() {
    datePurchase_filter.value = "";
    datePurchase_filter.disabled = false;
    btnPurchase.disabled = true;
    btncancel.setAttribute("hidden", "");
}


const query_IdP = async (dateF) => {
    var result = await main.getIdByDate(dateF);

    if (result.length > 0) {
        console.log("ID LOCALIZADO: ", result[0].idPurchase);
        id_P = result[0].idPurchase; 
        console.log("Id_P actual", id_P);
    } else {
        console.log("INSERTANDO FECHA");
        await main.newDate(dateF);

        // Wait to register the new ID
        await new Promise(resolve => setTimeout(resolve, 100)); 
        
        result = await main.getIdByDate(dateF); // Query again

        if (result.length > 0) {
            id_P = result[0].idPurchase;
            console.log("Nuevo ID asignado:", id_P);
        } else {
            console.error("No se pudo obtener el ID después de insertar la fecha.");
        }
    }
};




const product = document.getElementById('txt_product');
const description = document.getElementById('txt_description');
const price = document.getElementById('txt_price');
const quantity = document.getElementById('txt_quantity');
const branchstore = document.getElementById('txt_store');
const relevance = document.getElementById('txt_relevance');

newDtPurchaseDiv.addEventListener('submit', async (err) => {
    err.preventDefault();
    //console.log('Date: '+ dateFilter);
    let newDetailPurchase = {};

    if (product.value == "" || description.value == "" || price.value == "" || quantity.value == "" || branchstore.value == "" || relevance.value == "") {
        console.log("LLENR CAMPOS");
        return;
    }
    newDetailPurchase = {
        vchProduct: product.value,
        vchDescription: description.value,
        fltPrice: parseFloat(price.value),
        intQuantity: parseInt(quantity.value),
        //subtotal is auto
        idPurchase_fk: 0,
        idBranchstore_fk: branchstore.value,
        idRelevance_fk: relevance.value

    }
    purchaseDetails.push(newDetailPurchase);
    update_DtPreview();
    clearForm();
    //console.log("newDetailPurchase", newDetailPurchase);
})
/* Form: newDtPurchaseDiv  -|END|- */





const newPurchaseDiv = document.getElementById('newPurchaseDiv');

newPurchaseDiv.addEventListener('submit', async (event) => {
    event.preventDefault();

    /*
    if (purchaseDetails.length === 0) {
        console.log("No hay detalles agregados.");
        return;
    }
    */

    console.log("antes", id_P)
    await query_IdP(dateFilter);
    
    
    for (let purchase_dt of purchaseDetails) {
        purchase_dt.idPurchase_fk=id_P;
        console.log(purchase_dt)
    }
    
/*
    // Mostrar mensaje de confirmación
    if (!confirm("¿Are you sure you want to register these purchases?")) {
        return;
    }

    try {
        for (let purchase_dt of purchaseDetails) {
            await main.newpurchase(purchase_dt);
        }
        console.log("Compras registrada exitosamente.");

        // Limpiar la lista y la pantalla
        purchaseDetails = [];
        update_DtPreview();
        btnPurchase.disabled = true;
    } catch (error) {
        console.error("Error al registrar compra:", error);
        alert("Ocurrió un error al registrar la compra.");
    }
        */
});








let purchaseDetails = []; // Save details purchase temporaly
const cardDtList = document.querySelector('.card_dtList'); // Div view for the details

function update_DtPreview() {
    cardDtList.innerHTML = ''; // Clean list before update

    purchaseDetails.forEach((detail, index) => {
        let card = document.createElement('div');
        card.classList.add('purchaseCard');
        card.innerHTML = `
            <div class="infoDt">
                 <p><strong>Branchstore: </strong> ${branchstores[detail.idBranchstore_fk - 1].vchName}</p>
                <p><strong>Product: </strong> ${detail.vchProduct}</p>
                <i><strong>$${detail.fltPrice} * ${detail.intQuantity} = $${detail.fltPrice * detail.intQuantity}.00</strong></i>
            </div>
            <button onclick="removeDetail(${index})">Delete</button>
        `;
        //console.log("detail",detail)
        cardDtList.appendChild(card);
        //console.log("card", card)
    });

}


function removeDetail(index) {
    purchaseDetails.splice(index, 1);
    update_DtPreview();
}

function clearForm() {
    product.value = '';
    description.value = '';
    price.value = '';
    quantity.value = '';
    branchstore.selectedIndex = 0;
    relevance.selectedIndex = 0;
}

chargeForm();