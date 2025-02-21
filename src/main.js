const { BrowserWindow, Notification } = require('electron')
const { getConnection } = require('./sqlMoves/conectionDB')
const path = require('path')

/* Begin CRUDS boxCut */

//LOGIN

async function loginQuery(identity, password) {

  const query = "SELECT * FROM tbl_user " +
    "WHERE vchUser = ? AND vchPass = ? ";

  const conn = await getConnection();
  const results = await conn.query(query, [identity, password]);
  //console.log(results)
  return results;
}


// PURCHASES
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



async function newpurchase(detailpurchase) {
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
      'CALL SP_Insert_DtPurchase(?, ?, ?, ?, ?, ?, ?)',
      [
        detailpurchase.vchProduct,
        detailpurchase.vchDescription,
        detailpurchase.fltPrice,
        detailpurchase.intQuantity,
        detailpurchase.idPurchase_fk,
        detailpurchase.idBranchstore_fk,
        detailpurchase.idRelevance_fk
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
    const query = "CALL SP_UpdateTotalPurchase(?)"
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

//SP_UpdateTotalPurchase(?)

async function getPurchases(option, year, month, day) {
  let query = "";
  /*let queryResponsable = "SELECT ";*/
  if (option === "general") {
    query = "SELECT idPurchase, DATE_FORMAT(dtDate, '%a, %d/%m/%y') AS dtDate, fltTotal FROM tbl_purchases ORDER BY STR_TO_DATE(dtDate, '%Y-%m-%d') DESC"
  }
  else if (option === "filter") {
    query = "SELECT idPurchase, DATE_FORMAT(dtDate, '%a, %d/%m/%y') AS dtDate, fltTotal"
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

async function getDetailPurchases(idpurchase) {
  let query = "SELECT * FROM vw_purchaseDetail WHERE idP_fk =" + idpurchase + ";";

  const conn = await getConnection();
  const results = await conn.query(query)
  //console.log(results)
  return results;
}




async function editProduct(id) {
  console.log(id);
  /*
  const conn = await getConnection();
  const results = await conn.query("UPDATE tblProductos SET = ")
  */
  //console.log(results)
  //return results;
}

async function deleteProduct(id) {
  console.log(id);
  /*
  const conn = await getConnection();
  const results = await conn.query("DELETE * FROM tblProductos WHERE idProducto = "+id)
  */
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
      preload: path.join(__dirname, 'preload.js')
    }
  })

  //win.loadFile('index.html')
  //win.loadFile('./src/index.html')
  win.loadFile('./src/accessAdmin/purchases.html')

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

  newpurchase,
  updatePurchase,
  getPurchases,
  getDetailPurchases,

  /*
  newInvestment,
  getInvestments,
  getDetailInvestments,

  getProducts,
  editProduct,
  deleteProduct,*/
}