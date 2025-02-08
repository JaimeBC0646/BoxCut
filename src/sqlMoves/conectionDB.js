const mysql = require ('promise-mysql')

const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'db_boxcut',
  });

  function getConnection(){
      return connection;
  }
  /*
  function closeConnectionBD(){
      mysql.
      
  }
  */
  module.exports= { getConnection }