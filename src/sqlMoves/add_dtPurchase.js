const newDtPurchaseDiv = document.getElementById('newDtPurchaseDiv');

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



/* Form: newDtPurchaseDiv  -|START|- */
var dateFilter;
const datePurchase_filter = document.getElementById('dtP_Input');
const btncompra = document.getElementById('btn_addPurchase');
datePurchase_filter.addEventListener('change', () => {
    dateFilter = datePurchase_filter.value
    datePurchase_filter.disabled = true;
    //console.log('Fecha: '+ dateFilter);

    btncompra.disabled = false;
})


const query_IdP = async (dateF) => {
    var result = await main.getIdByDate(dateF);
    console.log(result)
    
    if(result.length>0){
        console.log("ID LOCALIZADO: ", result[0].idPurchase)
        return result[0].idPurchase;
    }
    else{
        console.log("INSERTANDO FECHA")
        await main.newDate(dateF);
        query_IdP(dateF);
    }
        
}



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

    if (dateFilter != null || dateFilter == "") {
        query_IdP(dateFilter);
        
        var id_P = await query_IdP(dateFilter)
        if (id_P != null) {
            
            newDetailPurchase = {
                vchProduct: product.value,
                vchDescription: description.value,
                fltPrice: parseFloat(price.value),
                intQuantity: parseInt(quantity.value),
                //subtotal is auto
                idPurchase_fk: id_P,
                idBranchstore_fk: branchstore.value,
                idRelevance_fk: relevance.value

            }
            purchaseDetails.push(newDetailPurchase);
            update_DtPreview();
            clearForm();
            
        }
        
    }
    else {
        console.log("Seleecciona una fecha!")
    }
    //console.log("newDetailPurchase", newDetailPurchase);



    //const result = await main.newSell(newDetailPurchase)
    //console.log(result)

})
/* Form: newDtPurchaseDiv  -|END|- */




let purchaseDetails = []; // Save details purchase temporaly
const cardDtList = document.querySelector('.card_dtList'); // Div view for the details

function update_DtPreview() {
    cardDtList.innerHTML = ''; // Clean list before update

    purchaseDetails.forEach((detail, index) => {
        let card = document.createElement('div');
        card.classList.add('purchaseCard');
        card.innerHTML = `
            <div class="infoDt">
                <p><strong>Product: </strong> ${detail.vchProduct}</p>
                <p>$${detail.fltPrice} * ${detail.intQuantity} = $${detail.fltPrice * detail.intQuantity}.00</p>
            </div>
            <button onclick="removeDetail(${index})">Eliminar</button>
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