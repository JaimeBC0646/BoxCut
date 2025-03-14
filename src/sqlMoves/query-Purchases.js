const { remote } = require('electron');
const main = remote.require('./main.js');


/*RDB selection   START*/
const rdbGeneral = document.getElementById('rdbGeneral');
const rdbFilter = document.getElementById('rdbFilter');
const date = document.getElementById('dtInput');

rdbGeneral.addEventListener('change', () => {
    date.disabled = true;
    /*if (rdbGeneral.checked) {
        console.log('Consulta general:');
    }
    */
    init();
});
rdbFilter.addEventListener('change', () => {
    date.disabled = false;
    /*
    if (rdbFilter.checked) {
        console.log('Consulta con fecha:');
    }
    */
    init();
});
date.addEventListener('change', () => {
    /*console.log('Fecha: '+date.value);*/
    init();
});
/*RDB selection   END*/



/*Query purchases    START*/
const purchasesList = document.getElementById('purchase')
let purchases = []

function renderPurchases(purchases) {
    //console.log("compras: ", purchases)
    purchasesList.innerHTML = '';

    let tableHTML = `<table>
    <thead>
        <tr>
            <th>DATE</th>
            <th>TOTAL</th>
            <th>ACTIONS</th>
        </tr>
    </thead>
    <tbody>`;

    if (purchases.length == 0) {
        purchasesList.innerHTML += tableHTML +=
            `<tbody>
                <tr>
                    <td align="center" colspan="3"> <h3><< NO DATA TO SHOW >></h3> </td>
                </tr>
            </tbody></table>`;
    }
    else {
        purchases.forEach((purchase, index) => {
            tableHTML += `
            <tr>
                <td><b>${purchase.dtDateFormated}</b></td>
                <td align="right"><b>$${purchase.fltTotal}.00</b></td>
                <td align="center"><button id="btnView_dtPurchase" class="btnView_dtPurchase" data-idPurchase="${purchase.idPurchase}" data-index="${index}" >Detail</button></td>
            </tr>
            `;
        });
        purchasesList.innerHTML += tableHTML += `</tbody></table>`;
    }



}

const getPurchases = async () => {
    let option;

    if (rdbGeneral.checked) {
        option = rdbGeneral.value
    }
    else {
        if (rdbFilter.checked) {
            option = rdbFilter.value
        }
    }

    const dtSelected = new Date(date.value);
    strDate = date.value;

    const year = dtSelected.getFullYear();
    const month = dtSelected.getMonth() + 1;
    const day = strDate.substring(8, 10);


    purchases = await main.getPurchases(option, year, month, day);
    /*
    console.log("date: "+ date.value);
    console.log("ASD op:"+ option+" yy:"+year+" mm:"+month+" dd:"+day);
    */
    renderPurchases(purchases);
}

async function init() {
    if (rdbGeneral.checked || (rdbFilter.checked && date.value != null)) {
        await getPurchases();
        renderdtPurchases(dtPurchases);
    }
}
/*Query purchases    END*/






/*Query Detailpurchases   START*/
const dtPurchasesList = document.getElementById('dtPurchase')
let dtPurchases = []

function renderdtPurchases(dtPurchases) {

    dtPurchasesList.innerHTML = '';

    let tableHTML = `<table>
    <thead>
        <tr>
            <th> PRODUCT OR SERVICE </th>
            <th> DESCRIPTION </th>
            <th> PRICE </th>
            <th> QUANTITY </th>

            <th> SUBTOTAL </th>
            <th> STORE / PLACE </th>
            <th> RELEVANCE </th>
            <th> ACTIONS </th>
        </tr>
    </thead>`;

    if (dtPurchases.length == 0) {
        dtPurchasesList.innerHTML += tableHTML +=
            `<tbody>
                <tr>
                    <td align="center" colspan="8"> <h2><< Select any purchase to detail >></h2> </td>
                </tr>
            </tbody></table>`;
    }
    else {
        dtPurchases.forEach(dtPurchase => {
            tableHTML += `
            <tr>
                <td>${dtPurchase.PoS}</td>
                <td>${dtPurchase.Description}</td>
                <td align="right">$${dtPurchase.Price}.00</td>
                <td align="center">${dtPurchase.Quantity}</td>
                
                <td align="right">$${dtPurchase.Subtotal}.00</td>
                <td align="center">${dtPurchase.Branchstore_Name}</td>
                <td>${dtPurchase.Relevance}</td>
                <td>
                    <div class="btnActions">
                        <img src ="../imgResources/editIcon.png" id="btnActionP" class="btnEdit_dtPurchase"  data-idEdit_DT="${dtPurchase.id_dtP}" data-idB_fk="${dtPurchase.idB_fk}" data-idR_fk="${dtPurchase.idR_fk}" data-idP_fk="${dtPurchase.idP_fk}" >
                        <img src ="../imgResources/deleteIcon.png" id="btnActionP" class="btnDelete_dtPurchase"  data-idDelete_DT="${dtPurchase.id_dtP}" >
                    </div>
                    
                </td>
            </tr>
            `;
        });
        dtPurchasesList.innerHTML += tableHTML += `</tbody></table>`;
    }
}




/* CHARGING FORM */
function charge_editForm(idDt, idB, idR) {
    chargeDate(idDt)
    charge_branchstores(idB);
    charge_revelances(idR);
}

let inDate = "";
const chargeDate = async (id_date) => {
    //console.log("id_d: ",id_date)
    var res = await main.getDateById(id_date);
    resDate = res[0].dtDateFormated;
    //console.log("fecha: ",resDate)

    const year = resDate.getFullYear();
    const p_month = resDate.getMonth() + 1;
    var month = p_month > 9 ? p_month : "0" + p_month;
    var day = resDate.getDate() > 9 ? resDate.getDate() : "0" + resDate.getDate();

    dateFormatted = year + "-" + month + "-" + day;
    //console.log(dateFormatted)
    document.getElementById("txt_date").value = dateFormatted;
}


/* Charge data: Branchstore  -|START|- */
let branchstores = [];
const charge_branchstores = async (idB) => {
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
        select.value = idB;
    }
}
/* Charge data: Branchstore  -|END|- */


/* Charge data: Relevance  -|START|- */
let revelances = [];
const charge_revelances = async (idR) => {
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
            select.value = idR;
        }
    }
}
/* Charge data: Relevance  -|END|- */


document.addEventListener('click', async (event) => {
    if (event.target.classList.contains('btnView_dtPurchase')) {
        const idPurchase = event.target.getAttribute('data-idPurchase');   //console.log(idPurchase);
        const indexPurchase = event.target.getAttribute('data-index');   //console.log(indexPurchase);
        //console.log(purchases[indexPurchase].dtDateFormated)

        const divDate = document.getElementById("dateDetailed");
        var dateSelecttoDetail = purchases[indexPurchase].dtDateFormated
        divDate.innerHTML = dateSelecttoDetail;
        init2(idPurchase);
    }

    if (event.target.classList.contains('btnEdit_dtPurchase')) {
        const idEdit_DT = event.target.getAttribute('data-idEdit_DT');   //console.log("Editado: ", idEdit_DT);
        const idB_fk = event.target.getAttribute('data-idB_fk');
        const idR_fk = event.target.getAttribute('data-idR_fk');
        const idP_fk = event.target.getAttribute('data-idP_fk');
        showDt_EditForm(idEdit_DT, idB_fk, idR_fk, idP_fk);
    }

    if (event.target.classList.contains('btnDelete_dtPurchase')) {
        const id_P_ref = event.target.getAttribute('data-idP_ref');   //console.log("IdP_Ref: ", id_P_ref);
        const idDelete_DT = event.target.getAttribute('data-idDelete_DT');

        const confirmed = await confirmMessage("Are you sure you want to delete this detail?");
        if (!confirmed) {
            showMessage("Action canceled!", "error");
            return;
        }

        deleteDetail(idDelete_DT);   //console.log("Eliminado: ", idDelete_DT);
        init();
        init2(id_P_ref);
    }
});

const getDetailpurchases = async (idPurchase) => {
    /*console.log(idVenta);*/
    dtPurchases = await main.getDetailPurchases(idPurchase);
    renderdtPurchases(dtPurchases);

}

var new_IdP = 0;
const query_IdP = async (dateF) => {
    var result = await main.getIdByDate(dateF);

    if (result.length > 0) {
        // console.log("ID LOCALIZADO: ", result[0].idPurchase);
        new_IdP = result[0].idPurchase;
        // console.log("Id_P actual", new_IdP);
    } else {
        // console.log("INSERTANDO FECHA");
        await main.newDate(dateF);

        // Wait to register the new ID
        await new Promise(resolve => setTimeout(resolve, 100));

        result = await main.getIdByDate(dateF); // Query again

        if (result.length > 0) {
            new_IdP = result[0].idPurchase;
            // console.log("Nuevo ID asignado:", new_IdP);
        } else {
            // console.error("No se pudo obtener el ID después de insertar la fecha.");
        }
    }
};


const showDt_EditForm = async (id_dtP_edit, idB_fk, idR_fk, idP_fk) => {

    const existingModal = document.getElementById('frm_editModal');
    if (existingModal) {
        existingModal.remove();
    }

    const row_infoDtP = await main.getDetailById(id_dtP_edit);
    //console.log(row_infoDtP[0]);

    // 1. Crear el modal en el HTML
    modalHTML = `
    <div id="frm_editModal">
        <div class="edit_form">
            <h2>Edit Purchase Detail</h2>
            <div class="purchaseInput">
                <label for="txt_product">Product:</label>
                <input type="text" id="txt_product" name="txt_product" value="${row_infoDtP[0].vchProduct}">
            </div>

            <div class="purchaseInput">
                <label for="txt_description">Description:</label>
                <textarea id="txt_description" name="txt_description"></textarea>
            </div>

            <div class="purchaseInput">
                <label for="price">Price:</label>
                <input type="text" id="txt_price" name="price" value="${row_infoDtP[0].fltPrice}">
            </div>

            <div class="purchaseInput">
                <label for="txt_quantity">Quantity:</label>
                <input type="number" id="txt_quantity" name="txt_quantity" value="${row_infoDtP[0].intQuantity}">
            </div>

            <div class="purchaseInput">
                <label for="store">Store / Place:</label>
                <select id="txt_store" name="txt_store">
                    <option>Select branchstore</option>
                </select>
            </div>

            <div class="purchaseInput">
                <label for="relevance">Relevance:</label>
                <select id="txt_relevance" name="txt_relevance">
                    <option>Select relevance</option>
                </select>
            </div>

            <div class="purchaseInput">
                <label>Date:</label>
                <input type="date" id="txt_date">
            </div>

            <div class="btn_EditForm">
                <img src="../imgResources/confirm_Icon.png" id="saveEdit">
                <img src="../imgResources/cancel_Icon.png" id="cancelEdit">
            </div>
        </div>
    </div>`;


    document.body.insertAdjacentHTML('beforeend', modalHTML);

    const modal = document.getElementById('frm_editModal');
    charge_editForm(idP_fk, idB_fk, idR_fk);

    const product = document.getElementById('txt_product');
    const description = document.getElementById('txt_description');
    description.value = row_infoDtP[0].vchDescription;
    const price = document.getElementById('txt_price');
    const quantity = document.getElementById('txt_quantity');
    const branchstore = document.getElementById('txt_store');
    const relevance = document.getElementById('txt_relevance');
    const date = document.getElementById('txt_date');
    date.value = inDate;
    const saveEdit = document.getElementById('saveEdit');
    const cancelEdit = document.getElementById('cancelEdit');
    cancelEdit.scrollIntoView({ behavior: 'smooth', block: 'center' });


    // 3. Guardar los cambios
    saveEdit.addEventListener('click', async () => {
        const confirmed = await confirmMessage("Are you sure you want to confirm edited details?");
        if (!confirmed) {
            showMessage("Action canceled!", "error");
            return;
        }

        let updatedData = {};
        updatedData = {
            id_dtPurchase: id_dtP_edit,
            vchProduct: product.value,
            vchDescription: description.value,
            fltPrice: parseFloat(price.value),
            intQuantity: parseInt(quantity.value),
            //subtotal is auto
            idPurchase_fk: 0,
            idBranchstore_fk: branchstore.value,
            idRelevance_fk: relevance.value
        }

        await query_IdP(date.value);
        updatedData.idPurchase_fk = new_IdP;


        await main.updateDetailPurchase(updatedData);
        showMessage("Detail updated!", "success", `Check details at ${date.value} changed successfully.`);
        init2(idP_fk);
        init(); // Recargar la tabla
        modal.remove();
    });


    // 4. Cancelar edición
    cancelEdit.addEventListener('click', () => {
        modal.remove();
    });


}




const deleteDetail = async (id_dtP_del) => {
    /*console.log(idVenta);*/
    await main.deleteDetailPurchases(id_dtP_del);

}

async function init2(idVenta) {
    /*console.log(idVenta);*/
    await getDetailpurchases(idVenta);
}
/*Query Detailpurchases   END*/



/*  -----| CHARGE VIEW |-----   */
init();




