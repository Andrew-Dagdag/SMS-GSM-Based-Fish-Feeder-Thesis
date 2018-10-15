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
let currentFID = null

app.use(express.static(__dirname + "/html"));
app.use(express.static(__dirname + "/css"));
// app.use(express.static(__dirname + "/js"));
app.use(express.static(__dirname + "/bower_components"));

app.use(bodyParser.urlencoded({extended:true}))

app.get('/', (request, response) => {
  response.sendFile('index.html');
});

app.get("/FishFeedIndex", (request, response) => {
  response.sendFile('units.html', {"root": "html/"})
});

app.get("/addFieldUnit", (request, response) => {
  response.sendFile('addUnit.html', {"root": "html/"})
});

/*********************
**AJAX POST REQUESTS**
*********************/

app.post('/addUnit', (request, response) => {
  let uid = request.body.uid
  let label = request.body.label
  let phoneno = request.body.phoneno
  let species = request.body.species
  let feederload = request.body.feederload
  let sql = "INSERT INTO `units` "
          + "(`fid`, `uid`, `label`, `phoneno`, `species`, `feederload`) "
          + "VALUES (NULL, '"+uid+"', '"+label+"', '"+phoneno+"', '"+species+"', '"+feederload+"')";
  // console.log(sql)
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }
    response.json(result)
  })
});

app.post('/logout', (request, response) => {
  userdata = {}
  currentFID = null
  response.send("Success")
});

app.post('/updateSched', (request, response) => {
  let fid = request.body.fid
  let sched = request.body.fullSched
  let amount = request.body.amount
  let sql = "UPDATE `schedule` SET `amount`="+amount+", `sched`='"+sched+"' WHERE `schedule`.`fid`="+fid
  // console.log(sql)
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }
    response.json(result)
  })
});

app.post('/getSched', (request, response) => {
  let fid = request.body.fid
  let sql = 'SELECT * from `schedule` WHERE fid='+fid
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }
    response.json(result)
  })
});

app.post('/setFID', (request, response) => {
  currentFID = request.body.fid
  response.send("Success")
});

app.post('/getFID', (request, response) => {
  response.json(currentFID)
});

app.post('/getFieldUnit', (request, response) => {
  let fid = request.body.fid
  let sql = 'SELECT * from `units` WHERE fid='+fid
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }
    currentFID = result[0].fid
    response.json(result)
  })
});

app.post('/getFieldUnits', (request, response) => {
  let uid = request.body.uid
  let sql = 'SELECT * FROM `units` WHERE uid='+uid
  con.query(sql, function(err, result){
    if(err){
      // console.log(err)
    }
    response.json(result)
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
    sql = "SELECT * FROM `units` WHERE uid="+userdata["uid"]+" LIMIT 1"
    con.query(sql, function(err, res){
      currentFID = res[0].fid
    })
    response.json(data)
  })
});

app.listen(2018, function(){
  console.log("Ayooo I started the server");
  con.query("SELECT * FROM `schedule`", function(err, result){
    let fieldUnits = []
    for(let i = 0; i < result.length; i++){
      let sched = result[i].sched.split(",")
      let fid = result[i].fid
      let start = sched[0].split(":")
      let endTime = sched[2].split(":")
      let interval = sched[1]
      let intervals = []
      for(let i = parseInt(start[0]); i < parseInt(endTime[0]); i += parseInt(interval)){
        // console.log("heh", i)
        intervals.push(i)
      }
      let load = result[i].amount
      fieldUnits.push({fid:fid, start:start, intervals:intervals, endTime:endTime, load:load})
    }
    // console.log(fieldUnits)
    setInterval(function(){
      let x = new Date()
      fieldUnits.forEach(unit => {
        let currentHour = x.getHours()
        let currentMinute = x.getMinutes()
        if(unit.start[1] == currentMinute){
          if(currentHour == unit.endTime[0]){
            if(currentMinute > unit.endTime[1]){
              return
            }
          }
          if(unit.intervals.includes(currentHour)){
            console.log("I am feeding feeder", unit.fid, "with", unit.load, "grams")
            //trigger function to text feeder to feed!
          }
        }
      });
    }, 60000)
  })
});