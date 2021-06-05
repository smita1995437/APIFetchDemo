//
//  Company.swift
//  APIFetchDemo
//
//  Created by Mac on 02/06/21.
//

import Foundation

struct User {
    
    var name: String?
    var email: String?
    var zipcode: String?
    var companyName: String?


init (name:String,email:String,zipcode:String,companyName:String) {
    
        self.name = name
        self.email = email
        self.zipcode = zipcode
        self.companyName = companyName
    }
    
}
