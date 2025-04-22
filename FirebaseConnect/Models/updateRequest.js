const express = require("express");
class updateRequest{
    #Link;
    #Name;
    #Password;
    constructor(Link,Name,Password){
        this.#Link = Link;
        this.#Name = Name;
        this.#Password = Password;
    }
    get Link(){
        return this.#Link;
    }
    get Name(){
        return this.#Name;
    }
    get Password(){
        return this.#Password;
    }
    set Link(Link){
        this.#Link = Link;
    }
    set Name(Name){
        this.Name = Name;
    }
    set Password(Password){
        this.#Password = Password;
    }
}
module.exports = updateRequest;