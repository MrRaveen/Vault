const express = require("express");
const p1 = require("../Service/gatPassProcess");
const p2 = new p1();//object
class getAllPasswords{
    async get(){
        try{
            const result = await p2.get1();
            return result;
        }
        catch(error){
            throw new Error('Error occured in getAllPasswords');
        }
    }
}
module.exports = getAllPasswords;