const express = require("express");
const p1 = require('../Service/saveProcess');
const p2 = new p1();
const Passwords2 = require('../Models/Passwords');
const PasswordsLive = new Passwords2();
class SavePassword{
    async save(obj){
        try{
           //call the object fun
           p2.savetoMain(obj);
        }catch(error){
            throw new Error('Error occured in the controller' + error);
        }
    }
}
module.exports = SavePassword;