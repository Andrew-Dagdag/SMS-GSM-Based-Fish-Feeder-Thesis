let express     = require("express")
let bodyParser  = require("body-parser")
let app         = express()
let mysql       = require("mysql")
let con         = mysql.createConnection({
                    host:"localhost",
                    user:"root",
                    password:"",
                    database:"autofishfeed"
                  })
let textCon     = mysql.createConnection({
                    host:"localhost",
                    user:"root",
                    password:"",
                    database:"smsserver"
                  })

app.use(express.static(__dirname + "/html"));
app.use(express.static(__dirname + "/bower_components"));

app.use(bodyParser.urlencoded({extended:true}))

app.get('/test', (request, response) => {
  console.log("SendingLandingPage")
  response.sendFile('testIndex.html', {"root": "html/"});
});

app.post('/getNumbers', (request, response) => {
  console.log("Getting Numbers")
  let query = "SELECT name, phoneno FROM users"
  con.query(query, function(err, res){
    response.json(res)
  })
});

app.post('/getOwnersAndUnits', (request, response) => {
  console.log("Getting Owners")
  let query = "SELECT users.name, units.label FROM users INNER JOIN units ON users.uid = units.uid"
  con.query(query, function(err, res){
    response.json(res)
  })
});

app.post('/sendDummyText', (request, response) => {
  let message = request.body.message
  let phoneno = request.body.phoneno

  let time = new Date().toISOString().slice(0, 19).replace('T', ' ')

  let query = "INSERT INTO `messagereceive` "
            + "(`Id`, `SendTime`, `MessageTo`, `MessageFrom`, `MessageText`) "
            + "VALUES "
            + "(NULL, '" + time + "', NULL, '"+phoneno+"', '"+message+"')"
  console.log(query)
  textCon.query(query, function(err, res){
    if(err){
      throw err
    }
  })
});

app.listen(2020, function(){
  console.log("Started Testing Server at localhost:2020")
})

