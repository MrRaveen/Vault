const express = require("express");
const { initializeApp, cert } = require("firebase-admin/app");
const { getFirestore, collection, getDocs } = require("firebase-admin/firestore"); // Admin SDK Firestore
const serviceAccount = require("../serviceAccKey.json");
const Passwords = require('../Models/Passwords');
const PasswordsLive = new Passwords();
const db = getFirestore();
const app = express();
class saveProcess{
    async savetoMain(obj){
        try{
             var test1 = obj.Link;
             const passCol = db.collection('passwords');
             const docRef = await passCol.add({
                Link: obj.Link,
                Name: obj.Name,
                Password: obj.Password,
                createdAt: new Date()
             });
             return docRef.id;
            // console.log(test1);
        }catch(error){
            throw new Error('Error occured in save service' + error);
        }
    }
}
module.exports = saveProcess;