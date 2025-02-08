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
            <th>ID</th>
            <th>DATE</th>
            <th>TOTAL</th>
            <th>ACTIONS</th>
        </tr>
    </thead>
    <tbody>`;
    purchases.forEach((purchase) => {
        tableHTML += `
        <tr>
            <td>${purchase.idPurchase}</td>
            <td>${purchase.dtDate}</td>
            <td align="right">$${purchase.fltTotal}.00</td>
            <td align="center"><button id="btnView_dtPurchase" class="btnView_dtPurchase" data-idPurchase="${purchase.idPurchase}">Detail</button></td>
        </tr>
        `;
    });
    purchasesList.innerHTML += tableHTML += `</tbody></table>`;
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
            <th>PRODUCT OR SERVICE</th>
            <th>DESCRIPTION</th>
            <th>PRICE</th>
            <th>QUANTITY</th>
            <th>SUBTOTAL</th>
            <th>STORE / PLACE</th>
            <th>RELEVANCE</th>
        </tr>
    </thead>`;

    if (dtPurchases === "") {
        dtPurchasesList.innerHTML += tableHTML +=
            `<tbody>
                <tr>
                    <td>CONTENIDOS</td>
                    <td>CONTENIDOS</td>
                    <td>CONTENIDOS</td>
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
            </tr>
            `;
        });
        dtPurchasesList.innerHTML += tableHTML += `</tbody></table>`;
    }
}

document.addEventListener('click', (event) => {
    if (event.target.classList.contains('btnView_dtPurchase')) {
        const idPurchase = event.target.getAttribute('data-idPurchase');
        /*console.log(idVenta);*/
        init2(idPurchase);
    }
});

const getDetailpurchases = async (idPurchase) => {
    /*console.log(idVenta);*/
    dtPurchases = await main.getDetailPurchases(idPurchase);
    renderdtPurchases(dtPurchases);

}

async function init2(idVenta) {
    /*console.log(idVenta);*/
    await getDetailpurchases(idVenta);
}
/*Query Detailpurchases   END*/



/*   START*/

init();