const express = require("express");
const { initializeApp, cert } = require("firebase-admin/app");
const { getFirestore, collection, getDocs } = require("firebase-admin/firestore"); // Admin SDK Firestore
const serviceAccount = require("../serviceAccKey.json");
// initializeApp({
//     credential: cert(serviceAccount),
//     databaseURL: "vault-e738d.firebaseio.com"
// });
const db = getFirestore();
const app = express();
class getPassProcess{
    async get1(){
        try{
            const passCol = db.collection('passwords');
            const citySnapshot = await passCol.get();
            console.log("Number of documents:", citySnapshot.size);
            return citySnapshot.docs.map(doc => (
                {
                    id: doc.id,
                    ...doc.data()
                }
            ));
        }catch(error){
            throw new Error('Error occured');
        }
    }
}
module.exports = getPassProcess;