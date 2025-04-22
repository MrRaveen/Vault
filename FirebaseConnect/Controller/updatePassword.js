const express = require('express');
const app = express();
const updateService = require('../Service/updateProcess');
const updateObj = new updateService();
class updatePassword{
    async update(documentID,updateRequest){
        try {
            // console.log("UPDATE PASSWORD CONT STAGE : " + documentID);
            const result = await updateObj.updateService(documentID,updateRequest);
            if(result == true){
                return true;
            }else{
                return false;
            }
        }catch(error){
            throw new Error('Error occured in update cont : ' + error);
        }
    }
}
module.exports = updatePassword;