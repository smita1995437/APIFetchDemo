//
//  ViewController.swift
//  APIFetchDemo
//
//  Created by Mac on 02/06/21.
//

import UIKit
class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetManager.shared.getUsersInfo { (message) in
            self.collectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
}


extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    //MARK: UICollectionViewDataSource Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        DBHelper.shared.read().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let userObj = DBHelper.shared.read()[indexPath.row]
        cell.Name.text = userObj.name
        cell.Email.text = userObj.email
        cell.Zip.text = userObj.zipcode
        cell.Company.text = userObj.companyName
        
        return cell
    }
    
    //MARK: UICollectionViewDelegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let AddVC = storyboard?.instantiateViewController(identifier: "AddlViewControllerID") as? AddViewController else {
            return
        }
        AddVC.userObject = DBHelper.shared.read()[indexPath.row]
        self.navigationController?.pushViewController(AddVC, animated: true)
    }
    
    //MARK: UICollectionViewDelegateFlowLayout Methods
    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2, height: view.frame.width / 2)
    }
}

        
        

