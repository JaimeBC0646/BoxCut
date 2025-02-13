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
  const results = await conn.query(query,[dtDate]);
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





/*
async function newpurchase(detailpurchase) {
  try {
    const conn = await getConnection();
    detailpurchase.fltPrecio = parseFloat(detailpurchase.fltPrecio)
    const result = await conn.query('INSERT INTO tbldetalleventa SET ?', detailpurchase)
    //const result = await conn.query('CALL SP_', detailpurchase)

    new Notification({
      title: 'Venta completada',
      body: 'Nueva venta registrada'
    }).show();

    detailpurchase.id = result.insertId
    return detailpurchase
  }
  catch (error) {
    console.log(error)
  }
}
  */





async function newpurchase(detailpurchase) {
  try {
    const conn = await getConnection();
    detailpurchase.fltPrecio = parseFloat(detailpurchase.fltPrecio)
    const result = await conn.query('INSERT INTO tbldetalleventa SET ?', detailpurchase)
    //const result = await conn.query('CALL SP_', detailpurchase)

    new Notification({
      title: 'Venta completada',
      body: 'Nueva venta registrada'
    }).show();

    detailpurchase.id = result.insertId
    return detailpurchase
  }
  catch (error) {
    console.log(error)
  }
}

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
  win.loadFile('./src/index.html')

  //win.webContents.openDevTools();
}




function createNewpurchaseFormWindow() {
  const newpurchaseFormWindow = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      enableRemoteModule: true,
      preload: path.join(__dirname, 'preload.js')
    }
  });

  newpurchaseFormWindow.loadFile('./src/accessEmployee/newDtPurchase.html'); // Reemplaza la ruta con la de tu formulario
  //newpurchaseFormWindow.webContents.openDevTools(); // Descomenta para abrir las DevTools
}


/*Ends Create windows App  */



/*Begin Exporting Functions / methods  */
module.exports = {
  createWindow,
  createNewpurchaseFormWindow,
  loginQuery,

  newDate,
  getIdByDate,
  getBranchstores,
  getRelevances,

  newpurchase,
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