//
//  AddViewController.swift
//  APIFetchDemo
//
//  Created by Mac on 02/06/21.
//

import UIKit

class AddViewController: UIViewController {
    
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Email: UILabel!
    @IBOutlet weak var Zip: UILabel!
    @IBOutlet weak var Company: UILabel!
  
    var userObject:User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Name.text = userObject?.name
        Email.text = userObject?.email
        Zip.text = userObject?.zipcode
        Company.text = userObject?.companyName
        
    }
    

}

