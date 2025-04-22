const express = require("express");
const { initializeApp, cert } = require("firebase-admin/app");
const { getFirestore, collection, getDocs } = require("firebase-admin/firestore"); // Admin SDK Firestore
const serviceAccount = require("../serviceAccKey.json");
const db = getFirestore();
const app = express();
class removeService{
    async removeProcess(documentID){
        try{
            const docRef = db.collection('passwords').doc(documentID);
            await docRef.delete();
            return true;
        }catch(error){
            throw new Error('Error occured in remove service ' + error);
        }
    }
}
module.exports = removeService;