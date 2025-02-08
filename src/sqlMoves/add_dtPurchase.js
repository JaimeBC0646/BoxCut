const detailPurchaseForm = document.getElementById('detailPurchaseForm');

const { remote } = require('electron');
const main = remote.require('./main.js');


/* CHARGING FORM */
function chargeForm() {
    charge_branchstores();
    charge_revelances();
}


/* Charge data: Branchstore  -|START|- */
const charge_branchstores = async () => {
    let branchstores = [];
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



/* Form: detailPurchaseForm  -|START|- */
var dateFilter;
const datePurchase_filter = document.getElementById('dtP_Input');

datePurchase_filter.addEventListener('change', () => {
    dateFilter = datePurchase_filter.value
    //console.log('Fecha: '+ dateFilter);
})

const product = document.getElementById('txt_product');
const description = document.getElementById('txt_description');
const price = document.getElementById('txt_price');
const quantity = document.getElementById('txt_quantity');
const branchstore = document.getElementById('txt_store');
const relevance = document.getElementById('txt_relevance');

detailPurchaseForm.addEventListener('submit', async (err) => {
    err.preventDefault();
    //console.log('Fecha: '+ dateFilter);


    let newDetailPurchase = {};

    if(dateFilter != null || dateFilter ==""){
        let result = [];
        result = await main.getIdByDate(dateFilter);
        //console.log('ID: ', result[0].idPurchase)

        if(result[0].idPurchase != null){
            newDetailPurchase = {
                vchProduct: product.value,
                vchDescription: description.value,
                fltPrice: parseFloat(price.value),
                intQuantity: parseInt(quantity.value),
                //subtotal is auto
                idPurchase_fk: result[0].idPurchase,
                idBranchstore_fk: branchstore.value,
                idRelevance_fk: relevance.value

            }
        }
    }
    else{
        console.log("Seleecciona una fecha!")
    }
    //console.log(newDetailPurchase);


    purchaseDetails.push(newDetailPurchase);
    update_DtPreview();
    clearForm();


    //const result = await main.newSell(newDetailPurchase)
    //console.log(result)

})
/* Form: detailPurchaseForm  -|END|- */




let purchaseDetails = []; // Save details purchase temporaly
const cardDtList = document.querySelector('.card_dtList'); // Div view for the details

function update_DtPreview() {
    cardDtList.innerHTML = ''; // Limpiar la lista antes de actualizar

    purchaseDetails.forEach((detail, index) => {
        let card = document.createElement('div');
        card.classList.add('purchaseCard');
        card.innerHTML = `
            <p><strong>Product:</strong> ${detail.vchProduct}</p>
            <p><strong>Price:</strong> ${detail.fltPrice}</p>
            <p><strong>Quantity:</strong> ${detail.intQuantity}</p>
            <p><strong>Subtotal:</strong> $${detail.fltPrice * detail.intQuantity}.00</p>
            <button onclick="removeDetail(${index})">Eliminar</button>
        `;
        cardDtList.appendChild(card);
    });
}

/* Función para eliminar un detalle de la lista */
function removeDetail(index) {
    purchaseDetails.splice(index, 1);
    update_DtPreview();
}

/* Función para limpiar los campos del formulario después de agregar un detalle */
function clearForm() {
    product.value = '';
    description.value = '';
    price.value = '';
    quantity.value = '';
    branchstore.selectedIndex = 0;
    relevance.selectedIndex = 0;
}

chargeForm();