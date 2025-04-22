const express = require("express");
const app = express();
app.use(express.json());
const route = express.Router(); // Create a router instance
const getAllPasswords = require('../Controller/getAllPasswords'); 
const SavePassword = require('../Controller/SavePassword');
const Passwords = require('../Models/Passwords');
const updateRequestFile = require('../Models/updateRequest');
const updateController = require('../Controller/updatePassword');
const removePassword = require('../Controller/removePassword');
const removeObject = new removePassword();
const updateContObject = new updateController();
const po1 = new getAllPasswords();
const po2 = new SavePassword();
route.get('/getAll', async (req, res) => {
    try {
        const data = await po1.get();
        res.send(data);
    } catch (error) {
      res.status(500).send("Error: " + error.message);
    }
});
route.post('/saveNew',async (req,res)=>{
    try{
        const {link:Link,name:Name,password:Password} = req.body;
        const passObject = new Passwords(Link,Name,Password);
        const id = po2.save(passObject);
        if(id != null){
            res.status(200).send('Saved');
        }else{
            res.status(500).send('Error occured when saving data');
        }
    }catch(error){
        res.status(500).send('Error : ' + error.message);
    }
});
route.put('/updateCard',async (req,res)=>{
    const {Id:id,link:Link,name:Name,password:Password} = req.body;
    //const {id, Link, Name, Password} = req.body;
    const updateObject = new updateRequestFile(Link,Name,Password);
    try{
        // console.log("ACCESS POINT STAGE : " + id);
        // console.log("ACCESS POINT STAGE : " + Link);
        // console.log("ACCESS POINT STAGE : " + Name);
        // console.log("ACCESS POINT STAGE : " + Password);
       const result = await updateContObject.update(id,updateObject);
       if(result == true){
        res.status(200).send(result);
       }else{
        console.log('Error in the update result (Access point)');
        res.status(500).send('Error in the update result (Access point)');
       }
    }catch(error){
        console.log('Internal error (access point)112 : ' + error);
        res.status(500).send('Internal error (access point)');
    }
});
route.delete('/deletePassword',async (req,res)=>{
    const {Id:id} = req.body;
    const result = await removeObject.removeNow(id);
    if(result == true){
        res.status(200).send('Data removed');
    }
    else{
        res.status(500).send('Error occured in access point (delete)' + result);
    }
});
module.exports = route;