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
let sha256      = require("sha256")
let userdata = {}
let feederdata = {}


app.use(express.static(__dirname + "/html"));
// app.use(express.static(__dirname + "/css"));
// app.use(express.static(__dirname + "/js"));
app.use(express.static(__dirname + "/bower_components"));

app.use(bodyParser.urlencoded({extended:true}))

app.get('/', (request, response) => {
  response.sendFile('index.html');
});

app.get("/FishFeedIndex", (request, response) => {
  response.sendFile('fishfeedindex.html', {"root": "html/"})
});

app.post('/getFieldUnits', (request, response) => {
  let uid = request.body.uid
  let sql = 'SELECT * FROM `units` WHERE uid='+uid
  con.query(sql, function(err){
    if(err){
      console.log(err)
    }
    con.query(sql, function(err, result){
      if(err){
        console.log(err)
      }
      // console.log(result)
      feederdata = result
      response.json(feederdata)
    })
  })
});

app.post('/getUserInfo', (request, response) => {
  response.json(userdata)
});

app.post('/userLogin', (request, response) => { //Ajax Request for Login
  let name = request.body.User
  let password = request.body.Pass
  let sql = 'SELECT * from `users` WHERE users.name="'+name+'"'
  // console.log("This is the query:", sql)
  con.connect(function(err){
    if(err){
      console.log(err)
    }
    // console.log("Connected to database! Checking user login info!")
    con.query(sql, function(err, result){
      if(err){
        console.log(err)
      }
      // console.log(result[0])
      let hashedPass = sha256(password)
      let data = {}
      data["success"] = false
      if(hashedPass == result[0].password){
        // console.log("Ayooo it passed lmao", hashedPass)
        // let uid = result[0].uid
        data["success"] = true
        userdata["user"] = result[0].name
        userdata["uid"] = result[0].uid
        userdata["user_phone"] = result[0].phoneno
      }
      response.json(data)
    })
  })
});

app.listen(2018, function(){
  console.log("Ayooo I started the server");
});