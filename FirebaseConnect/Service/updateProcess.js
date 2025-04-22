const express = require("express");
const { initializeApp, cert } = require("firebase-admin/app");
const { getFirestore, collection, getDocs } = require("firebase-admin/firestore"); // Admin SDK Firestore
const serviceAccount = require("../serviceAccKey.json");
const Passwords = require('../Models/Passwords');
const PasswordsLive = new Passwords();
const db = getFirestore();
const app = express();
class updateProcess{
    async updateService(documentID,updateRequest){
       try{
        // console.log(updateRequest.Link);
        // console.log("UPDATE PASSWORD SERVICE STAGE : " + documentID);
       const snapshot1 = await db.collection('passwords').doc(documentID);
       const snapshot = await snapshot1.get();
       if(!snapshot.exists){
         throw new Error('Document cannot found');
       }
       //convert into plain object
       let plainObj = {};
      //  console.log("UPDATE link SERVICE STAGE : " + updateRequest.Link);
      //  console.log("UPDATE name SERVICE STAGE : " + updateRequest.Name);
      //  console.log("UPDATE password SERVICE STAGE : " + updateRequest.Password);
       plainObj.Link = updateRequest.Link;
       plainObj.Name = updateRequest.Name;
       plainObj.Password = updateRequest.Password;
       await snapshot1.update(plainObj);
       return true;
       }catch(error){
        throw new Error('Error occured in update service : ' + error);
       }
    }
}
module.exports = updateProcess;