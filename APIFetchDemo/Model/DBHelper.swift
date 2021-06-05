//
//  DBHelper.swift
//  APIFetchDemo
//
//  Created by Mac on 02/06/21.
//

import Foundation
import SQLite3

    class DBHelper {
        static let shared = DBHelper()
        let tablename = "Company"
    
    private init()
    {
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    func createTable() {
            let createTableString = "CREATE TABLE IF NOT EXISTS Company(ID INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT,zipcode INT,companyName TEXT);"
            var createTableStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
            {
                if sqlite3_step(createTableStatement) == SQLITE_DONE
                {
                    print("Company table created.")
                } else {
                    print("Company table could not be created.")
                }
            } else {
                print("CREATE TABLE statement could not be prepared.")
            }
            sqlite3_finalize(createTableStatement)
        }
        
        func insert(userObj: User) {
            let insertStatementString = "INSERT INTO Company (name, email, zipcode, companyName) VALUES (?, ?, ?, ?);"
            var insertStatement: OpaquePointer? = nil
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
                sqlite3_bind_text(insertStatement, 1, ((userObj.name ?? "") as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, ((userObj.email ?? "") as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, ((userObj.zipcode ?? "") as NSString).utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, ((userObj.companyName ?? "") as NSString).utf8String, -1, nil)
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    print("Successfully inserted row.")
                } else {
                    print("Could not insert row.")
                }
            } else {
                print("INSERT statement could not be prepared.")
            }
            sqlite3_finalize(insertStatement)
        }
        func read() -> [User] {
            let queryStatementString = "SELECT * FROM Company;"
            var queryStatement: OpaquePointer? = nil
            var userObject : [User] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let zipcode = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                    let companyName = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                    
                    userObject.append(User(name: name, email: email, zipcode: zipcode, companyName: companyName))
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return userObject
        }
    }

