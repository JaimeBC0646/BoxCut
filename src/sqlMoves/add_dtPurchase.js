const { remote } = require('electron');
const main = remote.require('./main.js');


const newDtPurchaseDiv = document.getElementById('newDtPurchaseDiv');

/* CHARGING FORM */
function chargeForm() {
    charge_branchstores();
    charge_revelances();
    charge_categories();
}


let branchstores = [];
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

let revelances = [];
const charge_revelances = async () => {
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

let categories = [];
const charge_categories = async () => {
    categories = await main.getCategories();
    //console.log(revelances)

    if (categories) {
        categories.sort();   // Order A-Z
        addOptions("txt_category", categories);
    }

    // Add options into <select>
    function addOptions(domElement, categories) {
        var select = document.getElementsByName(domElement)[0];
        //console.log(categories[0].vchName);

        for (value in categories) {
            var option = document.createElement("option");
            option.value = categories[value].idCategory;
            option.text = categories[value].vchDescription;
            select.add(option);
        }
    }
}




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
        // console.log(id_P);
    }
    // console.log(dateFilter)
})
/* Form: newDtPurchaseDiv  -|END|- */


function dtRestart() {
    datePurchase_filter.value = "";
    datePurchase_filter.disabled = false;
    btnPurchase.disabled = true;
    btncancel.setAttribute("hidden", "");
}


const query_IdP = async (dateF) => {
    var result = await main.getIdByDate(dateF);

    if (result.length > 0) {
        // console.log("ID LOCALIZADO: ", result[0].idPurchase);
        id_P = result[0].idPurchase;
        // console.log("Id_P actual", id_P);
    } else {
        // console.log("INSERTANDO FECHA");
        await main.newDate(dateF);

        // Wait to register the new ID
        await new Promise(resolve => setTimeout(resolve, 100));

        result = await main.getIdByDate(dateF); // Query again

        if (result.length > 0) {
            id_P = result[0].idPurchase;
            // console.log("Nuevo ID asignado:", id_P);
        } else {
            // console.error("No se pudo obtener el ID después de insertar la fecha.");
        }
    }
};




const product = document.getElementById('txt_product');
const description = document.getElementById('txt_description');
const price = document.getElementById('txt_price');
const quantity = document.getElementById('txt_quantity');
const branchstore = document.getElementById('txt_store');
const relevance = document.getElementById('txt_relevance');
const category = document.getElementById('txt_category');

newDtPurchaseDiv.addEventListener('submit', async (err) => {
    err.preventDefault();
    //console.log('Date: '+ dateFilter);
    let newDetailPurchase = {};

    if (product.value == "" || description.value == "" || price.value == "" || quantity.value == "" 
        || branchstore.value == "Select branchstore" || relevance.value == "Select relevance" 
        || category.value == "Select category")
        {
        showMessage("Please complete the form, filling all the spaces", "error");
        // console.log("LLENR CAMPOS");
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
        idRelevance_fk: relevance.value,
        idCategory_fk: category.value

    }
    purchaseDetails.push(newDetailPurchase);
    //console.log("valor de branchstore: ", branchstore.value)
    cantArticles = cantArticles + parseInt(quantity.value);
    cantTotal = cantTotal + parseFloat(price.value * quantity.value);
    update_DtPreview();
    clearForm();
    //console.log("newDetailPurchase", newDetailPurchase);
})
/* Form: newDtPurchaseDiv  -|END|- */




var cantArticles = 0;
var cantTotal = 0;

const newPurchaseDiv = document.getElementById('newPurchaseDiv');

newPurchaseDiv.addEventListener('submit', async (event) => {
    event.preventDefault();


    if (purchaseDetails.length === 0) {
        showMessage("No details in list. Set details to continue", "error");
        return;
    }

    //console.log("antes", id_P);


    const confirmed = await confirmMessage("Are you sure you want to confirm this purchase?");
    if (!confirmed) {
        showMessage("Action canceled!", "error");
        return;
    }


    // Register purchase (with the date)
    await query_IdP(dateFilter);

    for (let purchase_dt of purchaseDetails) {
        purchase_dt.idPurchase_fk = id_P;
        //console.log(purchase_dt)
    }
    //console.log("list: ",purchaseDetails)   


    try {
        // Register details
        for (let purchase_dt of purchaseDetails) {
            await main.newpurchase(purchase_dt);
        }

        // Update purchase
        await main.updatePurchase(id_P);

        // Message actions, clean and update list & recharge forms
        showMessage("Purchases registered!", "success", `Inserted ${purchaseDetails.length} details successfully.`);
        purchaseDetails = [];
        cantArticles = 0;
        cantTotal = 0;
        update_DtPreview();
        btnPurchase.disabled = true;
        dtRestart();


    } catch (error) {
        //console.error("Error al registrar compra:", error);
        //showMessage("Error: Date not founded :(", "error");
    }

});























let purchaseDetails = []; // Save details purchase temporaly
const cardDtList = document.querySelector('.card_dtList'); // Div view for the details


function update_DtPreview() {
    const p_Articles = document.getElementById('lblArticle');
    const p_Total = document.getElementById('lblTotal');


    // Clean list before update
    cardDtList.innerHTML = '';
    p_Articles.innerHTML = '';
    p_Total.innerHTML = '';


    p_Articles.innerHTML = ` ${cantArticles}`;
    p_Total.innerHTML = `$${cantTotal}.00`;

    purchaseDetails.forEach((detail, index) => {
        let card = document.createElement('div');
        card.classList.add('purchaseCard');
        card.innerHTML = `
            <div class="rowInfo">
                <div class="infoDt">
                    <p><strong>Branchstore: </strong> ${branchstores[detail.idBranchstore_fk - 1].vchAbbreviation}</p>
                    <p><strong>Product: </strong> ${detail.vchProduct}</p>
                    <p><i><strong>$${detail.fltPrice} * ${detail.intQuantity} = $${detail.fltPrice * detail.intQuantity}.00</strong></i></p>
                </div>
                <div class="infoDt">
                    <p><strong>Description: </strong>${detail.vchDescription}</p>
                    <p><strong>Relevance: </strong>${revelances[detail.idRelevance_fk - 1].vchDescription}</p>
                    <p><strong>Category: </strong>${categories[detail.idCategory_fk - 1].vchDescription}</p>
                </div>
            </div>
            <button onclick="removeDetail(${index})">Delete</button>
        `;
        //console.log("detail",detail)
        cardDtList.appendChild(card);
        //console.log("card", card)
    });

}

var dtP_Deleted;
function removeDetail(index) {
    //console.log("index: ", index);
    dtP_Deleted = purchaseDetails[index];
    //console.log("Del position: ", dtP_Deleted)
    purchaseDetails.splice(index, 1);

    cantArticles = cantArticles - parseInt(dtP_Deleted.intQuantity);
    cantTotal = cantTotal - parseFloat(dtP_Deleted.fltPrice * dtP_Deleted.intQuantity);
    update_DtPreview();
}

function clearForm() {
    product.value = '';
    description.value = '';
    price.value = '';
    quantity.value = '';
    branchstore.selectedIndex = 0;
    relevance.selectedIndex = 0;
    category.selectedIndex = 0;
}


chargeForm();

module.exports = { charge_branchstores };