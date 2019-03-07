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

app.get("/register", (request, response) => {
  response.sendFile('register.html', {"root": "html/"})
});

app.get("/profile", (request, response) => {
  response.sendFile('profile.html', {"root": "html/"})
});

/*********************
**AJAX POST REQUESTS**
*********************/

app.post('/getDailyScheduleLength', (request, response) => {
  con.query("SELECT * FROM `schedule` WHERE fid=" + currentFID, function(err, result){
    let fieldUnits = []
    for(let i = 0; i < result.length; i++){
      let sched = result[i].sched.split(",")
      let fid = result[i].fid
      let start = sched[0].split(":")
      let endTime = sched[2].split(":")
      let interval = sched[1]
      let intervals = []
      for(let i = parseInt(start[0]); i < parseInt(endTime[0]); i += parseInt(interval)){
        intervals.push(i)
      }
      response.send(String(intervals.length))

      // let load = result[i].amount
      // fieldUnits.push({fid:fid, start:start, intervals:intervals, endTime:endTime, load:load})

    }
    // response.send(Object.keys(fieldUnits).length)
    // response.send(fieldUnits.length)
  })
});

app.post('/getSampleStats', (request, response) => {
  let sql = "SELECT * FROM `sample` WHERE `fid`="+currentFID+" ORDER BY `sample`.`timestamp` ASC"
  con.query(sql, function(err, result){
    if (err){
      console.log(err)
    }
    response.json(result)    
  })
});

app.post('/getFeedHist', (request, response) => {
  let sql = "SELECT * FROM `feedhistory` WHERE `fid`="+currentFID+" ORDER BY `feedhistory`.`timestamp` ASC"
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }
    response.json(result)
  }) 
});

app.post('/addUser', (request, response) => {
  let username = request.body.username
  let password = sha256(request.body.password)
  let userno = request.body.userno
  let returnUID = {}
  let sql = "INSERT INTO `users` "
          + "(`uid`, `name`, `password`, `phoneno`) "
          + "VALUES (NULL, '"+username+"', '"+password+"', '"+userno+"')";
  console.log(sql)
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }else{
      con.query("SELECT uid FROM `users` ORDER BY `users`.`uid` DESC LIMIT 1", function(err,result2){
        returnUID["uid"] = result2[0].uid
        response.json(returnUID)
      })
    }
  })
});

app.post('/addUnit', (request, response) => {
  let uid = request.body.uid
  let label = request.body.label
  let phoneno = request.body.phoneno
  let species = request.body.species
  let feederload = request.body.feederload
  let sql = "INSERT INTO `units` "
          + "(`fid`, `uid`, `label`, `phoneno`, `species`, `feederload`) "
          + "VALUES (NULL, '"+uid+"', '"+label+"', '"+phoneno+"', '"+species+"', '"+feederload+"')";
  console.log(sql)
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }
    response.json(result)
  })

  con.query("SELECT `fid` FROM `units` ORDER BY `units`.`fid` DESC LIMIT 1", function(err, result){
    let fid = result[0].fid
    let amount = request.body.amount
    let sched = request.body.schedule
    let schedSQL  = "INSERT INTO `schedule` "
                  + "(`fid` ,    `sched`    ,     `amount`) VALUES ('"
                  + fid + "','" + sched + "', '" + amount + "')"
    con.query(schedSQL, function(err, res){
      if(err){
        throw err
      }
    })
  })
});

app.post('/updateUnit', (request, response) => {
  console.log("B O I")
  let label = request.body.label
  let phoneno = request.body.phoneno
  let species = request.body.species
  let feederload = request.body.feederload
  let sql = "UPDATE `units` "
          + "SET `label` = '"+label+"', `phoneno` = '"+phoneno+"', `species` = '"+species+"', `feederload` = '"+feederload+"' "
          + "WHERE `fid` = '"+currentFID+"'"
  console.log(sql)
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }
    response.json(result)
  })

  con.query("SELECT `fid` FROM `units` ORDER BY `units`.`fid` DESC LIMIT 1", function(err, result){
    let fid = result[0].fid
    let amount = request.body.amount
    let sched = request.body.schedule
    let schedSQL  = "UPDATE `schedule` "
                  + "SET `sched` = '" + sched + "', `amount` = '" + amount + "' "
                  + "WHERE `fid` = '"+fid+"'"
    con.query(schedSQL, function(err, res){
      if(err){
        throw err
      }
    })
  })
});

app.post('/updateUser', (request, response) => {
  console.log("B O I")
  let uid = request.body.uid
  let name = request.body.name
  let phoneno = request.body.phoneno
  let sql = "UPDATE `users` "
          + "SET `name` = '"+name+"', `phoneno` = '"+phoneno+"' "
          + "WHERE `uid` = '"+uid+"'"
  console.log(sql)
  con.query(sql, function(err, result){
    if(err){
      console.log(err)
    }
    response.json(result)
  })
  userdata["user"] = name
  userdata["user_phone"] = phoneno
});

app.post('/logout', (request, response) => {
  userdata = {}
  currentFID = null
  response.send("Success")
});

app.post('/updateSched', (request, response) => {
  let fid = currentFID
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

/***************************************
***Const Functions for repeating code***
***************************************/

const sendTextMessage = (message, number) => {
  //set query for text message
  console.log()
  console.log("I'm sending the text '" + message + "' with the number =>" + number)
  let messageQuery = "INSERT INTO `messagesend` (`Id`, `MessageFrom`, `MessageTo`, `MessageText`) VALUES (NULL, NULL, '"+number+"', '"+message+"')"
  // console.log(messageQuery)
  // textCon.query(messageQuery, function(err, res){
  //   if(err)
  //     throw err
  // })
}

const feedNow = (fid, amount, userphone, text) => {
  let query = "SELECT `feederload` FROM `units` WHERE fid="+fid
  con.query(query, function(err, res){
    let feederload = parseInt(res[0].feederload) - parseInt(amount)
    let newLoad = "UPDATE `units` SET `feederload` = '"+feederload+"' WHERE `units`.`fid` = "+fid
    con.query(newLoad, function(err, res){
      if(err){
        throw err
      }
    })
    if(feederload <= 300){ //less than 500 grams
      let sql = "SELECT `users`.`phoneno`, `units`.`label` FROM `units` INNER JOIN `users` ON `users`.`uid`=`units`.`uid` WHERE `units`.`fid`="+fid
      con.query(sql, function(err, res){
        let phoneno = res[0].phoneno
        let label = res[0].label
        let message = label + " has " + feederload + "grams remaining"
        sendTextMessage(message, phoneno)
      })
    }

    // let currentTime = new Date().toISOString().slice(0, 19).replace('T', ' ');
    let currentTime = new Date().toISOString().slice(0, 19).replace('T', ' ');
    console.log(currentTime)
    let feedHist  = "INSERT INTO `feedhistory` "
                  + "(`fid`, `feedamt`, `timestamp`, `type`, `index`) VALUES ('"
                  + fid + "', '" + amount + "', '" + currentTime + "', '" + (userphone==undefined?"Scheduled":"Manual") + "', NULL)"
    con.query(feedHist, function(err, res){
      if(err){
        throw err
      }
    })
    console.log(feederload)
    if(userphone !== undefined && text !== undefined){
      message = "Successfully sent feed signal to field unit: " + text + " with remaining feed: " + feederload + "g"
      sendTextMessage(message, userphone)
    }
  })
}

app.listen(2018, function(){
  console.log("Ayooo I started the server at localhost:2018");
  setInterval(function(){
    let fieldUnits = []
    con.query("SELECT * FROM `schedule`", function(err, result){
      for(let i = 0; i < result.length; i++){
        let sched = result[i].sched.split(",")
        let fid = result[i].fid
        let start = sched[0].split(":")
        let endTime = sched[2].split(":")
        let interval = sched[1]
        let intervals = []
        for(let i = parseInt(start[0]); i < parseInt(endTime[0]); i += parseInt(interval)){
          intervals.push(i)
        }
        let load = result[i].amount
        fieldUnits.push({fid:fid, start:start, intervals:intervals, endTime:endTime, load:load})
      }
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
            let feederSQL = "SELECT `phoneno` FROM `units` WHERE `fid`="+unit.fid
            feedNow(unit.fid, unit.load)
            con.query(feederSQL, function(err, result){
              let phoneno = result[0].phoneno
              let message = "feed," + unit.load
              sendTextMessage(message, phoneno)
            })
          }
        }
      });
    })
  }, 60000)

  setInterval(function(){
    console.log("I'm checking for texts lol")
    let query = "SELECT * FROM `messagereceive`"
    textCon.query(query, function(err, result0){
      // console.log(result0)
      for(let i = 0; i < result0.length; i++){
        // console.log("With the message:", result0[i].MessageText)
        let phoneno = result0[i].MessageFrom
        let checkPhoneSQL = "SELECT * FROM `users` WHERE `users`.`phoneno`='"+phoneno+"'"
        let textID = result0[i].Id
        // let text = result0[i].MessageText.replace(/\r\n/g, "").replace(/ /g,"").split(",")

        let text = result0[i].MessageText.replace(/\r\n/g, "").split(",")
        for(let z = 0; z < text.length; z++){
          text[z] = text[z].trim()
        }

        console.log(text)
        let deleteMessage = "DELETE FROM `messagereceive` WHERE `messagereceive`.`Id` = "+textID
        textCon.query(deleteMessage, function(err, res){ if(err) throw err})
        con.query(checkPhoneSQL, function(err, result1){
          if(result1.length == 0){
            //text error, not a registered phone number
            let message = "Error: Not a registered phone number"
            sendTextMessage(message, phoneno)
            return
          }

          if(text[0].toUpperCase() == "FIELDUNITS" || text[0].toUpperCase() == "FIELD UNITS"){
            let fieldQuery = "SELECT label FROM `units` WHERE `units`.`uid`="+result1[0].uid
            con.query(fieldQuery, function(err, res){
              if(res.length == 0){
                let message = "No field units for registered user: "+result1[0].name
                sendTextMessage(message, phoneno)
                return
              }
              let message = "Field Units Count: " + res.length
              for(let i = 0; i < res.length; i++){
                message += "\r\n->" + res[i].label
              }
              sendTextMessage(message, phoneno)
            })
            return
          }else if(text[0].toUpperCase() == "HELP"){
            let message1 =   "Possible Commands:\r\n"
                message1 +=  "Feed: 'feed, unit1, 500g'\r\n"
                message1 +=  "Schedule: 'schedule, unit2'\r\n"
                message1 +=  "Amount: 'amount, unit3'\r\n"
            // console.log("Sending First section")
            sendTextMessage(message1, phoneno)

            let message2  =  "Species: 'species, unit2'\r\n"
                message2 +=  "Show Data: 'Show data, articuno'\r\n"
                message2 +=  "Field Units: 'Field units'\r\n"
            sendTextMessage(message2, phoneno)

            let message3  =  "Fish Sample: 'Fish Sample, unit2, 90cm, 5kg'\r\n"
                message3 +=  "Rename: 'rename, unit3, label, newName'\r\n"
                message3 +=  "Rename: 'rename, unit3, species, newSpecies"
            sendTextMessage(message3, phoneno)
            return
          } 

          let fieldUnitSQL = "SELECT * FROM `units` WHERE `units`.`uid`="+result1[0].uid+" AND `units`.`label`='"+text[1]+"'"
          con.query(fieldUnitSQL, function(err, result2){
            if(result2.length == 0){
              let message = "Error: field unit '" + text[1] + "' does not exist for user " + result1[0].name
              console.log(message)
              sendTextMessage(message, phoneno)
              //text error, field unit does not exist for user
              return
            }
            let type = text[0].toUpperCase()
            if(type == "FEED"){
              //make a text to feed
              if(text[2] === undefined || isNaN(Number(text[2]))){
                let message = "No amount specified and/or non-numeric characters, feeding failed"
                sendTextMessage(message, phoneno)
                return
              }else if(Number(text[2])%100 > 0){
                let message = "Feeder only feeds in 100g increments"
                sendTextMessage(message, phoneno)
                return
              }else if(Number(text[2]) > result2[0].feederload){
                let message = "Feeder only has " + result2[0].feederload + "g left. Command failed"
                sendTextMessage(message, phoneno)
                return
              }else if(Number(text[2]) < 0){
                let message = "Cannot feed in negative increments. Command failed"
                sendTextMessage(message, phoneno)
                return
              }
              let unitPhoneNo = result2[0].phoneno
              let message = "feed," + text[2]
              sendTextMessage(message, unitPhoneNo)

              feedNow(result2[0].fid, text[2], phoneno, text[1])
            }else if(type == "SCHEDULE"){
              //make query to get sched, then send as text
              let getSched = "SELECT sched FROM `schedule` WHERE `schedule`.`fid`="+result2[0].fid
              con.query(getSched, function(err, res){
                if(err)
                  throw err
                let sched = res[0].sched.split(",")
                let message = "Schedule for unit: " + text[1] + " is START TIME: " + sched[0] + ", END TIME: " + sched[2] + ", INTERVAL: Every " + sched[1] + " hours"
                sendTextMessage(message, phoneno)
              })
            }else if(type == "AMOUNT"){
              let amount = result2[0].feederload
              let message = "User: " + result1[0].name + ", Field Unit: " + text[1] + ", Feed Left (estimate): " + amount + "g"
              sendTextMessage(message, phoneno)
              //make a text to return amount of feed left
              //e.g. "User: name, Field Unit: label, Feed Left (estimate): XXXX g"
            }else if(type == "SPECIES"){
              let species = result2[0].species
              let message = "User: " + result1[0].name + ", Field Unit: " + text[1] + ", Species: " + species
              sendTextMessage(message, phoneno)
              //make a text to return species
              //e.g. "User: name, Field Unit: label, Species: species"
            }else if(type == "RENAME"){
              let renameType = text[2].toUpperCase()
              if(renameType == "LABEL"){
                //make a query to update label to new label
                let labelQuery = "UPDATE `units` SET `label`='"+text[3]+"' WHERE `units`.`fid`="+result2[0].fid
                con.query(labelQuery, function(err, res){ if(err) throw err })
              }else if(renameType == "SPECIES"){
                let speciesQuery = "UPDATE `units` SET `species`='"+text[3]+"' WHERE `units`.`fid`="+result2[0].fid
                con.query(speciesQuery, function(err, res){ if(err) throw err })
                //make a query to update species to new species
              }else{
                let message = "Invalid update. Only label or species can be changed. Command failed."
                sendTextMessage(message, phoneno)
              }
            }else if(type == "SHOWDATA" || type == "SHOW DATA"){
              let amount = result2[0].feederload
              let species = result2[0].species
              let getSched = "SELECT sched FROM `schedule` WHERE `schedule`.`fid`="+result2[0].fid
              con.query(getSched, function(err, res){
                let sched = res[0].sched.split(",")
                let schedMessage = "Schedule for unit: " + text[1] + " is START TIME: " + sched[0] + ", END TIME: " + sched[2] + ", INTERVAL: Every " + sched[1] + " hours"
                let message = "Field Unit: " + text[1] + "\r\n"
                message += "Feed Amount (Estimate): " + amount + " g\r\n"
                message += "Species: " + species + "\r\n"
                message += schedMessage
                sendTextMessage(message, phoneno)
              })
            }else if(type == "FISHSAMPLE" || type == "FISH SAMPLE"){
            // 2018-10-31 00:00:00
              let size = text[2]
              let weight = text[3]
              let fid = result2[0].fid
              let timestamp = new Date().toISOString().slice(0, 19).replace('T', ' ')
              let addSampleQuery = "INSERT INTO `sample` (`fid`, `size`, `weight`, `timestamp`) VALUES ('"
                              + fid + "', '" + size + "', '" + weight + "', '" + timestamp + "')"
              console.log(addSampleQuery)
              // con.query(addSampleQuery, function(err, res){ if(err) throw err})
            }else{
              let message = "Command unknown"
              sendTextMessage(message, phoneno)
            }
          })
        })
      }
    })
  }, 5000)
});