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
        purchases.forEach((purchase) => {
            tableHTML += `
            <tr>
                <td>${purchase.dtDateFormated}</td>
                <td align="right">$${purchase.fltTotal}.00</td>
                <td align="center"><button id="btnView_dtPurchase" class="btnView_dtPurchase" data-idPurchase="${purchase.idPurchase}">Detail</button></td>
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
                        <img src ="../imgResources/editIcon.png" id="btnActionP" class="btnEdit_dtPurchase"  data-idEdit_DT="${dtPurchase.id_dtP}" data-idP_ref="${dtPurchase.idP_fk}">
                        <img src ="../imgResources/deleteIcon.png" id="btnActionP" class="btnDelete_dtPurchase"  data-idDelete_DT="${dtPurchase.id_dtP}" data-idP_ref="${dtPurchase.idP_fk}">
                    </div>
                    
                </td>
            </tr>
            `;
        });
        dtPurchasesList.innerHTML += tableHTML += `</tbody></table>`;
    }
}


document.addEventListener('click', async (event) => {
    if (event.target.classList.contains('btnView_dtPurchase')) {
        const idPurchase = event.target.getAttribute('data-idPurchase');   //console.log(idPurchase);
        init2(idPurchase);
    }


    if (event.target.classList.contains('btnEdit_dtPurchase')) {
        const id_P_ref = event.target.getAttribute('data-idP_ref');
        const idEdit_DT = event.target.getAttribute('data-idEdit_DT');   //console.log("Editado: ", idEdit_DT);
        showDt_EditForm(idEdit_DT, id_P_ref);
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

const showDt_EditForm = async (id_dtP_del) => {
    // 1. Crear el modal en el HTML
    const modalHTML = `
    <div id="editModal" class="modal hide">
        <div class="modal-content">
            <h2>Edit Purchase Detail</h2>
            <label>Product/Service:</label>
            <input type="text" id="editPoS">
            <label>Description:</label>
            <input type="text" id="editDescription">
            <label>Price:</label>
            <input type="number" id="editPrice">
            <label>Quantity:</label>
            <input type="number" id="editQuantity">
            <button id="saveEdit">Save</button>
            <button id="cancelEdit">Cancel</button>
        </div>
    </div>`;

    document.body.insertAdjacentHTML('beforeend', modalHTML);

    const modal = document.getElementById('editModal');
    const editPoS = document.getElementById('editPoS');
    const editDescription = document.getElementById('editDescription');
    const editPrice = document.getElementById('editPrice');
    const editQuantity = document.getElementById('editQuantity');
    const saveEdit = document.getElementById('saveEdit');
    const cancelEdit = document.getElementById('cancelEdit');
    let currentEditId = null;

    // 2. Capturar el click en el botón de edición
    document.addEventListener('click', async (event) => {
        if (event.target.classList.contains('btnEdit_dtPurchase')) {
            idEdit = event.target.getAttribute('data-idEdit_DT');
            console.log("id edit: ", idEdit)
            // Obtener los datos actuales del registro
            const row = event.target.closest('tr');
            editPoS.value = row.children[0].textContent;
            editDescription.value = row.children[1].textContent;
            editPrice.value = row.children[2].textContent.replace('$', '').trim();
            editQuantity.value = row.children[3].textContent;

            // Mostrar el modal
            modal.classList.remove('hide');
        }
    });

    // 3. Guardar los cambios
    saveEdit.addEventListener('click', async () => {
        const updatedData = {
            id: currentEditId,
            PoS: editPoS.value,
            Description: editDescription.value,
            Price: parseFloat(editPrice.value),
            Quantity: parseInt(editQuantity.value)
        };

        await main.updateDetailPurchase(updatedData);
        modal.classList.add('hide');
        init(); // Recargar la tabla
    });

    // 4. Cancelar edición
    cancelEdit.addEventListener('click', () => {
        modal.classList.add('hide');
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




