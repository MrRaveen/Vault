const express = require('express');
const app = express();
const removeService = require('../Service/removeService');
const removeObj = new removeService();
class removePassword{
    async removeNow(documentID){
        try{
            const result = removeObj.removeProcess(documentID);
            return true;
        }catch(error){
            throw new Error('Error occured in remove controller : ' + error);
        }
    }
}
module.exports = removePassword;