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
    if (event.target.classList.contains('btnNewLoan')) {
        charge_newLoanForm();
    }

    if (event.target.classList.contains('btnEdit_L')) {
        const idEdit_Loan = event.target.getAttribute('data-idEdit_Loan'); console.log("Editado: ", idEdit_Loan);
        showLoan_EditForm(idEdit_Loan);
    }

    if (event.target.classList.contains('btnDelete_L')) {
        const idDelete_Loan = event.target.getAttribute('data-idDelete_Loan');
        console.log("classID: ", idDelete_Loan);
        const confirmed = await confirmMessage("Are you sure you want to delete this detail?");
        if (!confirmed) {
            showMessage("Action canceled!", "error");
            return;
        }

        deleteLoanInfo(idDelete_Loan);   //console.log("Eliminado: ", idDelete_Loan);
        init();
    }
});




const charge_newLoanForm = async () => {
    // Creat edit form
    const buttonNewLoan = document.getElementById("btnNewLoan");
    buttonNewLoan.setAttribute("hidden", "");
    modalHTML = `
    <div id="frm_insertModal">
        <div class="insert_form">
            <h2>New Loan</h2>
            <div class="inputForm">
                <label for="txt_borrower">Borrower:</label>
                <input type="text" id="txt_borrower" name="txt_borrower">
            </div>

            <div class="inputForm">
                <label for="txt_description">Description:</label>
                <input id="txt_description" name="txt_description"></input>
            </div>

            <div class="inputForm">
                <label for="txt_amount">Amount:</label>
                <input type="text" id="txt_amount" name="txt_amount">
            </div>

            <div class="inputForm">
                <label for="txt_remaining">Remaining:</label>
                <input type="number" id="txt_remaining" name="txt_remaining">
            </div>

            <div class="inputForm">
                <label for="txt_status">Status:</label>
                <select id="txt_status" name="txt_status">
                    <option value="">Select status</option>
                    <option value="PAID">PAID</option>
                    <option value="PENDING">PENDING</option>
                </select>
            </div>

            <div class="inputForm">
                <label for="txt_date">Date:</label>
                <input type="date" id="txt_date">
            </div>

            <div class="btn_EditForm">
                <Button id="btnAddLoan"> ADD LOAN</Button>
                <Button id="btnCancelLoan"> CANCEL</Button>
            </div>
        </div>
    </div>`;



    document.body.insertAdjacentHTML('beforeend', modalHTML);


    const modal = document.getElementById('frm_insertModal');

    const borrower = document.getElementById('txt_borrower');
    const description = document.getElementById('txt_description');
    const amount = document.getElementById('txt_amount');
    const remaining = document.getElementById('txt_remaining');
    const status = document.getElementById('txt_status');
    const date = document.getElementById('txt_date');

    const saveNewLoan = document.getElementById('btnAddLoan');
    const cancelLoan = document.getElementById('btnCancelLoan');
    cancelLoan.scrollIntoView({ behavior: 'smooth', block: 'center' });


    // Save changes
    saveNewLoan.addEventListener('click', async () => {
        const confirmed = await confirmMessage("Are you sure you want to confirm new loan?");
        if (!confirmed) {
            showMessage("Action canceled!", "error");
            return;
        }

        let loanData = {};
        loanData = {
            vchBorrower: borrower.value,
            fltAmountM: amount.value,
            vchDescription: description.value,
            dtDate: date.value,
            fltRemaining: remaining.value,
            vchStatus: status.value
        }

        await main.newLoan(loanData);
        showMessage("Loan registrated!", "success", `borrower.value has $remaining.value  remaining.`);
        //init();
        modal.remove();
        buttonNewLoan.removeAttribute("hidden", "");
        init()
    });

    // Cancel edit
    cancelLoan.addEventListener('click', () => {
        showMessage("Loan canceled!", "error", `The register was canceled`);
        modal.remove();
        buttonNewLoan.removeAttribute("hidden", "");
    });
}






const chargeDate = async (res_date) => {
    const year = res_date.getFullYear();
    const p_month = res_date.getMonth() + 1;
    var month = p_month > 9 ? p_month : "0" + p_month;
    var day = res_date.getDate() > 9 ? res_date.getDate() : "0" + res_date.getDate();

    dateFormatted = year + "-" + month + "-" + day;
    //console.log(dateFormatted)
    document.getElementById("txt_date").value = dateFormatted;
}



const showLoan_EditForm = async (idEdit_Loan) => {

    const row_infoLoan = await main.getLoanById(idEdit_Loan);
    //console.log(row_infoLoan[0].dtDate);

    
    // Creat edit form
    modalHTML = `
    <div id="frm_insertModal">
        <div class="insert_form">
            <h2>New Loan</h2>
            <div class="inputForm">
                <label for="txt_borrower">Borrower:</label>
                <input type="text" id="txt_borrower" name="txt_borrower" value="${row_infoLoan[0].vchBorrower}">
            </div>

            <div class="inputForm">
                <label for="txt_description">Description:</label>
                <textarea id="txt_description" name="txt_description"></textarea>
            </div>

            <div class="inputForm">
                <label for="txt_amount">Amount:</label>
                <input type="text" id="txt_amount" name="txt_amount" value="${row_infoLoan[0].fltAmountM}">
            </div>

            <div class="inputForm">
                <label for="txt_remaining">Remaining:</label>
                <input type="number" id="txt_remaining" name="txt_remaining" value="${row_infoLoan[0].fltRemaining}">
            </div>

            <div class="inputForm">
                <label for="txt_status">Status:</label>
                <select id="txt_status" name="txt_status">
                    <option value="">Select status</option>
                    <option value="PAID">PAID</option>
                    <option value="PENDING">PENDING</option>
                </select>
            </div>

            <div class="inputForm">
                <label for="txt_date">Date:</label>
                <input type="date" id="txt_date">
            </div>

            <div class="btn_EditForm">
                <Button id="btnAddLoan"> ADD LOAN</Button>
                <Button id="btnCancelLoan"> CANCEL</Button>
            </div>
        </div>
    </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modalHTML);

    const modal = document.getElementById('frm_editModal');
    //charge_editForm(idP_fk, idB_fk, idR_fk);


    const borrower = document.getElementById('txt_borrower');
    const description = document.getElementById('txt_description');
    description.value = row_infoLoan[0].vchDescription;
    const amount = document.getElementById('txt_amount');
    const remaining = document.getElementById('txt_remaining');
    const status = document.getElementById('txt_status');
    //const date = document.getElementById('txt_date');
    chargeDate(row_infoLoan[0].dtDate);
    const saveEdit = document.getElementById('btnAddLoan');
    const cancelEdit = document.getElementById('btnCancelLoan');
    cancelEdit.scrollIntoView({ behavior: 'smooth', block: 'center' });


    // Save changes
    saveEdit.addEventListener('click', async () => {
        const confirmed = await confirmMessage("Are you sure you want to confirm edited details?");
        if (!confirmed) {
            showMessage("Action canceled!", "error");
            return;
        }

        let updated_loanData = {};
        updated_loanData = {
            vchBorrower: borrower.value,
            fltAmountM: amount.value,
            vchDescription: description.value,
            dtDate: date.value,
            fltRemaining: remaining.value,
            vchStatus: status.value,
            idLoan: idEdit_Loan
        }



        await main.updateLoan(updated_loanData);
        showMessage("Detail updated!", "success", `Check details at ${date.value} changed successfully.`);
        init();
        modal.remove();
    });


    // Cancel edit
    cancelEdit.addEventListener('click', () => {
        modal.remove();
    });


}

const deleteLoanInfo = async (idDelete_Loan) => {
    console.log("FuncID: ", idDelete_Loan);
    await main.deleteLoan(idDelete_Loan);

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
            var colorStatus = (loan.vchStatus == 'PAID' ? 'green' : 'red');
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
                        <img src ="../imgResources/editIcon.png" id="btnEdit_L" class="btnEdit_L" data-idEdit_Loan="${loan.idLoan}" >
                        <img src ="../imgResources/deleteIcon.png" id="btnDelete_L" class="btnDelete_L" data-idDelete_Loan="${loan.idLoan}" >
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




