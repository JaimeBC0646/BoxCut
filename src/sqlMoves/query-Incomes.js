const { remote } = require('electron');
const main = remote.require('./main.js');


/*RDB selection   START*/
const rdbGeneral = document.getElementById('rdbGeneral');
const rdbFilter = document.getElementById('rdbFilter');
//const date = document.getElementById('dtInput');

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
/*
date.addEventListener('change', () => {
    //console.log('Fecha: '+date.value);
    init();
});
*/
/*RDB selection   END*/



document.addEventListener('click', async (event) => {
    if (event.target.classList.contains('btnEdit_dtPurchase')) {
        const idEdit_Loan = event.target.getAttribute('data-idEdit_Loan');   //console.log("Editado: ", idEdit_Loan);
        showLoan_EditForm(idEdit_Loan);
    }
});



const showLoan_EditForm = async (idEdit_Loan) => {

    const existingModal = document.getElementById('frm_editModal');
    if (existingModal) {
        existingModal.remove();
    }

    const row_infoLoan = await main.getLoanById(idEdit_Loan);
    console.log(row_infoLoan[0]);

    /*
    // Creat edit form
    modalHTML = `
    <div id="frm_editModal">
        <div class="edit_form">
            <h2>Edit Purchase Detail</h2>
            <div class="inputForm">
                <label for="txt_product">Product:</label>
                <input type="text" id="txt_product" name="txt_product" value="${row_infoLoan[0].vchProduct}">
            </div>

            <div class="inputForm">
                <label for="txt_description">Description:</label>
                <textarea id="txt_description" name="txt_description"></textarea>
            </div>

            <div class="inputForm">
                <label for="price">Price:</label>
                <input type="text" id="txt_price" name="price" value="${row_infoLoan[0].fltPrice}">
            </div>

            <div class="inputForm">
                <label for="txt_quantity">Quantity:</label>
                <input type="number" id="txt_quantity" name="txt_quantity" value="${row_infoLoan[0].intQuantity}">
            </div>

            <div class="inputForm">
                <label for="store">Store / Place:</label>
                <select id="txt_store" name="txt_store">
                    <option>Select branchstore</option>
                </select>
            </div>

            <div class="inputForm">
                <label for="relevance">Relevance:</label>
                <select id="txt_relevance" name="txt_relevance">
                    <option>Select relevance</option>
                </select>
            </div>

            <div class="inputForm">
                <label>Date:</label>
                <input type="date" id="txt_date">
            </div>

            <div class="btn_EditForm">
                <img src="../imgResources/confirm_Icon.png" id="saveEdit">
                <img src="../imgResources/cancel_Icon.png" id="cancelEdit">
            </div>
        </div>
    </div>`;
    */


    document.body.insertAdjacentHTML('beforeend', modalHTML);

    const modal = document.getElementById('frm_editModal');
    charge_editForm(idP_fk, idB_fk, idR_fk);

    const product = document.getElementById('txt_product');
    const description = document.getElementById('txt_description');
    description.value = row_infoLoan[0].vchDescription;
    const price = document.getElementById('txt_price');
    const quantity = document.getElementById('txt_quantity');
    const branchstore = document.getElementById('txt_store');
    const relevance = document.getElementById('txt_relevance');
    const date = document.getElementById('txt_date');
    date.value = inDate;
    const saveEdit = document.getElementById('saveEdit');
    const cancelEdit = document.getElementById('cancelEdit');
    cancelEdit.scrollIntoView({ behavior: 'smooth', block: 'center' });


    // Save changes
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


    // Cancel edit
    cancelEdit.addEventListener('click', () => {
        modal.remove();
    });


}





/*Query loans    START*/
const loansList = document.getElementById('loan')
let loans = []

function renderLoans(loans) {
    //console.log("compras: ", loans)
    loansList.innerHTML = '';

    let tableHTML = `<table>
    <thead>
        <tr>
            <th>BORROWER</th>
            <th>DESCRIPTION</th>
            <th>AMOUNT</th>
            <th>DATE</th>
            <th>REMAINING</th>
            <th>STATUS</th>
            <th>ACTIONS</th>
        </tr>
    </thead>
    <tbody>`;

    if (loans.length == 0) {
        loansList.innerHTML += tableHTML +=
            `<tbody>
                <tr>
                    <td align="center" colspan="3"> <h3><< NO DATA TO SHOW >></h3> </td>
                </tr>
            </tbody></table>`;
    }
    else {
        loans.forEach((loan) => {
            var colorStatus = (loan.vchStatus == 'PAID'? 'green' : 'red');
            tableHTML += `
            <tr>
                <td><b>${loan.vchBorrower}</b></td>
                <td width="20%" ><b>${loan.vchDescription}</b></td>
                <td align="right"><b>$${loan.fltAmountM}.00</b></td>
                <td><b>${loan.dtDateFormated}</b></td>
                <td align="right"><b>$${loan.fltRemaining}.00</b></td>

                <td style="color: ${colorStatus}";> <b>${loan.vchStatus}</b></td>

                <td>
                    <div class="btnActions">
                        <img src ="../imgResources/editIcon.png" id="btnActionP" class="btnEdit_dtPurchase"  data-idEdit_Loan="${loan.idLoan}" >
                        <img src ="../imgResources/deleteIcon.png" id="btnActionP" class="btnDelete_dtPurchase"  data-idDelete_Loan="${loan.idLoan}" >
                    </div>
                    
                </td>
            </tr>
            `;
        });
        loansList.innerHTML += tableHTML += `</tbody></table>`;
    }



}

const getLoans = async () => {
    let option;

    if (rdbGeneral.checked) {
        option = rdbGeneral.value
    }
    else {
        if (rdbFilter.checked) {
            option = rdbFilter.value
        }
    }

    //const dtSelected = new Date(date.value);
    //strDate = date.value;

    /*
    const year = dtSelected.getFullYear();
    const month = dtSelected.getMonth() + 1;
    const day = strDate.substring(8, 10);
    */

    loans = await main.getLoans();
    /*
    console.log("date: "+ date.value);
    console.log("ASD op:"+ option+" yy:"+year+" mm:"+month+" dd:"+day);
    */
    renderLoans(loans);
}


/*Query loans    END*/







async function init() {
    if (rdbGeneral.checked || (rdbFilter.checked && date.value != null)) {
        await getLoans();
    }
}



/*  -----| CHARGE VIEW |-----   */
init();




