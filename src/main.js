const { BrowserWindow, Notification } = require('electron')
const { getConnection } = require('./sqlMoves/conectionDB')

/* Begin CRUDS boxCut asd */

/* -----| LOGIN |-----*/

async function loginQuery(identity, password) {

  const query = "SELECT * FROM tbl_user " +
    "WHERE vchUser = ? AND vchPass = ? ";

  const conn = await getConnection();
  const results = await conn.query(query, [identity, password]);
  //console.log(results)
  return results;
}


/* -----| PURCHASES |-----*/
async function newDate(dtDate) {
  try {
    const conn = await getConnection();
    const result = await conn.query("INSERT INTO tbl_purchases (dtDate) VALUES (DATE(?));", dtDate)
    //const result = await conn.query('CALL SP_', detailpurchase)

    new Notification({
      title: 'Success',
      body: 'New date registered '
    }).show();

    dtDate.id = result.insertId
    return dtDate
  }
  catch (error) {
    console.log(error)
  }
}

async function getIdByDate(dtDate) {
  const query = "SELECT idPurchase FROM tbl_purchases WHERE DATE(dtDate) = DATE(?);"
  const conn = await getConnection();
  const results = await conn.query(query, [dtDate]);
  //console.log(results)
  return results;
}

async function getBranchstores() {

  const query = "SELECT * FROM tbl_branchstore";

  const conn = await getConnection();
  const results = await conn.query(query);
  //console.log(results)
  return results;
}

async function getRelevances() {

  const query = "SELECT * FROM tbl_relevance";

  const conn = await getConnection();
  const results = await conn.query(query);
  //console.log(results)
  return results;
}

async function getCategories() {

  const query = "SELECT * FROM tbl_category";

  const conn = await getConnection();
  const results = await conn.query(query);
  //console.log(results)
  return results;
}





/* -----| DETAILS PRODUCT |-----*/

async function newpurchase(detailpurchase) {
  try {
    const conn = await getConnection();

    // Transform values for each column
    detailpurchase.fltPrice = parseFloat(detailpurchase.fltPrice);
    detailpurchase.intQuantity = parseInt(detailpurchase.intQuantity);
    detailpurchase.idPurchase_fk = parseInt(detailpurchase.idPurchase_fk);
    detailpurchase.idBranchstore_fk = parseInt(detailpurchase.idBranchstore_fk);
    detailpurchase.idRelevance_fk = parseInt(detailpurchase.idRelevance_fk);
    detailpurchase.idCategory_fk = parseInt(detailpurchase.idCategory_fk);

    // CALL SP
    const result = await conn.query(
      'CALL SP_Insert_DtPurchase(?, ?, ?, ?, ?, ?, ?, ?)',
      [
        detailpurchase.vchProduct,
        detailpurchase.vchDescription,
        detailpurchase.fltPrice,
        detailpurchase.intQuantity,

        detailpurchase.idPurchase_fk,
        detailpurchase.idBranchstore_fk,
        detailpurchase.idRelevance_fk,
        detailpurchase.idCategory_fk
        
      ]
    );

    /* // Mostrar notificación
    new Notification({
      title: 'Purchase complete',
      body: 'New details registrated'
    }).show();
    */

    return result; // Retorna el resultado de la inserción
  }
  catch (error) {
    console.error("Error al registrar la compra:", error);
    throw error; // Relanzar el error para manejarlo en otro lado si es necesario
  }
}

async function updatePurchase(id_P_fk) {
  try {
    const conn = await getConnection();

    // CALL SP
    const query = "CALL SP_UpdateTotalPurchase_gen(?)"
    const result = await conn.query(query, [id_P_fk]);

    /* // Mostrar notificación
    new Notification({
      title: 'Purchase updated',
      body: 'Total updated with details'
    }).show();
    */

    return result; // Retorna el resultado de la inserción
  }
  catch (error) {
    console.error("Error al registrar la compra:", error);
    throw error; // Relanzar el error para manejarlo en otro lado si es necesario
  }
}

async function getPurchases(option, year, month, day) {
  let query = "";
  /*let queryResponsable = "SELECT ";*/
  if (option === "general") {
    query = "SELECT idPurchase, DATE_FORMAT(dtDate, '%a, %d/%m/%y') AS dtDateFormated, fltTotal FROM tbl_purchases ORDER BY dtDate DESC"
  }
  else if (option === "filter") {
    query = "SELECT idPurchase, DATE_FORMAT(dtDate, '%a, %d/%m/%y') AS dtDateFormated, fltTotal"
      + " FROM tbl_purchases"
      + " WHERE YEAR(dtDate) = " + year
      + " AND MONTH(dtDate) = " + month
      + " AND DAY(dtDate) =" + day
  }

  const conn = await getConnection();
  const results = await conn.query(query)
  //console.log("main op:"+ option+" yy:"+year+" mm:"+month+" dd:"+day);
  /*console.log(results)*/
  return results;
}

async function getDateById(id_Date) {
  const query = "SELECT dtDate AS dtDateFormated FROM tbl_purchases WHERE idPurchase = ?"
  const conn = await getConnection();
  const results = await conn.query(query, [id_Date]);
  //console.log(results)
  return results;
}

async function getDetailById(id_dt) {
  let query = "SELECT * FROM tbl_dt_purchases WHERE id_dtPurchase =" + id_dt + ";";

  const conn = await getConnection();
  const results = await conn.query(query)
  //console.log(results)
  return results;
}

async function getDetailPurchases(idpurchase) {
  let query = "SELECT * FROM vw_purchaseDetail WHERE idP_fk =" + idpurchase + " ORDER BY id_dtP;";

  const conn = await getConnection();
  const results = await conn.query(query)
  //console.log(results)
  return results;
}

async function updateDetailPurchase(detailpurchase) {
  try {
    const conn = await getConnection();

    // Transform values for each column
    detailpurchase.fltPrice = parseFloat(detailpurchase.fltPrice);
    detailpurchase.intQuantity = parseInt(detailpurchase.intQuantity);
    detailpurchase.idPurchase_fk = parseInt(detailpurchase.idPurchase_fk);
    detailpurchase.idBranchstore_fk = parseInt(detailpurchase.idBranchstore_fk);
    detailpurchase.idRelevance_fk = parseInt(detailpurchase.idRelevance_fk);

    // CALL SP
    const result = await conn.query(
      'CALL SP_UpdateDetailInfo(?, ?, ?, ?, ?, ?, ?, ?,?)',
      [
        detailpurchase.id_dtPurchase,
        detailpurchase.vchProduct,
        detailpurchase.vchDescription,
        detailpurchase.fltPrice,
        detailpurchase.intQuantity,
        //subtotal is auto
        detailpurchase.idPurchase_fk,
        detailpurchase.idBranchstore_fk,
        detailpurchase.idRelevance_fk,
        detailpurchase.idCategory_fk
      ]
    );

    return result; // Retorna el resultado de la inserción
  }
  catch (error) {
    console.error("Error al registrar la compra:", error);
    throw error; // Relanzar el error para manejarlo en otro lado si es necesario
  }
}

async function deleteDetailPurchases(id) {
  //console.log(id);

  const conn = await getConnection();
  const results = await conn.query("DELETE FROM tbl_dt_purchases WHERE id_dtPurchase = " + id);

  //console.log(results)
}





/* -----| LOANS |-----*/
async function newLoan(loan) {
  try {
    const conn = await getConnection();

    // Transform values for each column
    loan.fltAmountM = parseFloat(loan.fltAmountM);
    loan.fltRemaining = parseFloat(loan.fltRemaining);


    // CALL SP
    const result = await conn.query(
      'CALL SP_Insert_Loan(?, ?, ?, ?, ?, ?)',
      [
        loan.vchBorrower,
        loan.fltAmountM,
        loan.vchDescription,
        loan.dtDate,
        loan.fltRemaining,
        loan.vchStatus
      ]
    );

    /* // Mostrar notificación
    new Notification({
      title: 'Purchase complete',
      body: 'New details registrated'
    }).show();
    */

    return result; // Retorna el resultado de la inserción
  }
  catch (error) {
    console.error("Error al registrar la compra:", error);
    throw error; // Relanzar el error para manejarlo en otro lado si es necesario
  }
}

async function getLoans() {
  let query = "";
  query = "SELECT idLoan, vchBorrower, fltAmountM, vchDescription, DATE_FORMAT(dtDate, '%a, %d/%m/%y') AS dtDateFormated, fltRemaining, vchStatus FROM tbl_loans"

  /*if (option === "general") {
    query = "SELECT idPurchase, DATE_FORMAT(dtDate, '%a, %d/%m/%y') AS dtDateFormated, fltTotal FROM tbl_purchases ORDER BY dtDate DESC"
  }
  else if (option === "filter") {
    query = "SELECT idPurchase, DATE_FORMAT(dtDate, '%a, %d/%m/%y') AS dtDateFormated, fltTotal"
      + " FROM tbl_purchases"
      + " WHERE YEAR(dtDate) = " + year
      + " AND MONTH(dtDate) = " + month
      + " AND DAY(dtDate) =" + day
  }
      */

  const conn = await getConnection();
  const results = await conn.query(query)

  return results;
}
getLoans

async function getLoanById(idL) {
  let query = "SELECT * FROM tbl_loans WHERE idLoan =" + idL + ";";

  const conn = await getConnection();
  const results = await conn.query(query)
  //console.log(results)
  return results;
}

async function updateLoan(loan) {
  try {
    const conn = await getConnection();

    // Transform values for each column
    loan.fltAmountM = parseFloat(loan.fltAmountM);
    loan.fltRemaining = parseFloat(loan.fltRemaining);

    // CALL SP
    const result = await conn.query(
      'CALL SP_UpdateLoanInfo(?, ?, ?, ?, ?, ?, ?)',
      [
        loan.vchBorrower,
        loan.fltAmountM,
        loan.vchDescription,
        loan.dtDate,
        loan.fltRemaining,
        loan.vchStatus,
        loan.idLoan
      ]
    );

    return result; // Retorna el resultado de la inserción
  }
  catch (error) {
    console.error("Error al registrar la compra:", error);
    throw error; // Relanzar el error para manejarlo en otro lado si es necesario
  }
}

async function deleteLoan(id) {
  //console.log(id);

  const conn = await getConnection();
  const results = await conn.query("DELETE FROM tbl_loans WHERE idLoan = " + id);

  //console.log(results)
}








/*Begin Create windows App  */
function createWindow() {
  const win = new BrowserWindow({
    width: 1080,
    height: 800,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      enableRemoteModule: true,
      //preload: path.join(__dirname, 'preload.js')
    }
  })

  //win.loadFile('index.html')
  //win.loadFile('./src/index.html')
  win.loadFile('./src/accessAdmin/loans.html')

  //win.webContents.openDevTools();
}



/*Ends Create windows App  */



/*Begin Exporting Functions / methods  */
module.exports = {
  createWindow,
  loginQuery,

  newDate,
  getIdByDate,
  getBranchstores,
  getRelevances,
  getCategories,

  newpurchase,
  updatePurchase,
  getPurchases,

  getDateById,
  getDetailById,
  getDetailPurchases,
  updateDetailPurchase,
  deleteDetailPurchases,

  newLoan,
  getLoans,
  getLoanById,
  updateLoan,
  deleteLoan,
  //getLoanByFilter,
  /*
  newInvestment,
  getInvestments,
  getDetailInvestments,

  getProducts,
  getDateById,
  editProduct,
  deleteProduct,*/
}