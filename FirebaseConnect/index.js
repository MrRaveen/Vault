const express = require("express");
const { initializeApp, cert } = require("firebase-admin/app");
const serviceAccount = require("./serviceAccKey.json");
initializeApp({
  credential: cert(serviceAccount),
  databaseURL: "vault-e738d.firebaseio.com"
});
const app = express();
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
const pl1 = require("./Routes/AccessPoint");
app.use('/Access',pl1);
app.listen(3000);