const{createWindow} = require('./main')
const{app} = require('electron')

/* Conecction do DB */
require('./sqlMoves/conectionDB')

/* Recharge the app with every code change*/
require('electron-reload')(__dirname)

app.allowRenderProcessReuse = false;

/* STARTS APP*/
app.whenReady().then(() => {
    createWindow()
  
    app.on('activate', () => {
      if (BrowserWindow.getAllWindows().length === 0) {
        createWindow()
      }
    })
  })
  
  app.on('window-all-closed', () => {
    if (process.platform !== 'darwin') {
      app.quit()
    }
  })