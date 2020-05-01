//
//  SecondViewController.swift
//  Test1
//
//  Created by mac  on 2020/4/30.
//  Copyright © 2020年 appCoda. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{

    let apiUrl = URL(string : "https://jsonplaceholder.typicode.com/photos");
    var Titles: [String] = []
    var count: Int = 0
    var model = [User]()
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    var globalID: Int = 0
    var globalURL: String = ""
    var globalTitle: String = ""
    
    struct User {
        var albumID: Int
        var id: Int
        var title: String
        var url: String
        var thumbnailUrl: String
        init(_ dictionary: [String: Any]) {
            self.albumID = dictionary["albumId"] as? Int ?? 0
            self.id = dictionary["id"] as? Int ?? 0
            self.title = dictionary["title"] as? String ?? ""
            self.url = dictionary["url"] as? String ?? ""
            self.thumbnailUrl = dictionary["thumbnailUrl"] as? String ?? ""
        }
    }

    @IBOutlet weak var JsonCollectionView: UICollectionView!
    
    @IBOutlet weak var JsonCollectionViewLayout: UICollectionViewFlowLayout!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.count


    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = model[indexPath.row];
        //print(row)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Itemcell", for: indexPath) as! MyCollectionViewCell;
        

        if(model.count != 0){
            if let title = row.title as? String{
                cell.MycellTitle.text = title
                cell.MycellTitle.adjustsFontSizeToFitWidth=true
            }
            if let id = row.id as? Int{
                cell.MycellID.text = String(id)
                
            }
            
            let ImageString = row.thumbnailUrl
            let imageUrl = NSURL(string: ImageString)
            let imageData = NSData(contentsOf: imageUrl!  as URL)
            
            if(imageData != nil){
                cell.MycellImage.image = UIImage(data: imageData! as Data)
            }
            
        }
        //cell.MycellID.text = self.model[0].id as? String
        //cell.MycellTitle.text = self.model[0].title
        //print("successed")
         return cell;
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionWidth = collectionView.bounds.width
        return CGSize(width: collectionWidth/4, height: collectionWidth/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mData = model[indexPath.row]
        
        self.globalID = mData.id
        self.globalURL = mData.url
        self.globalTitle = mData.title
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "LastView") as! MyLastViewController
        navigationController?.pushViewController(destination, animated: true)
        performSegue(withIdentifier: "segue", sender: self)
        
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            // Setup new view controller
            let vc = segue.destination as! MyLastViewController
            vc.verificationId = String(self.globalID)
            vc.verificationURL = self.globalURL
            vc.verificationTitle = self.globalTitle
        }
    }
    
    func loadData(){
        let task = URLSession.shared.dataTask(with: apiUrl!){
            (data , response , error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    dataResponse, options: [])
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                    for dic in jsonArray{
                        self.model.append(User(dic)) // adding now value in Model array
                    }
                self.count = self.model.count
                DispatchQueue.main.async {
                    self.JsonCollectionView.reloadData()
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        JsonCollectionView.delegate = self
        JsonCollectionView.dataSource = self
        JsonCollectionViewLayout.minimumInteritemSpacing = 0
        JsonCollectionViewLayout.minimumLineSpacing = 0
        JsonCollectionViewLayout.scrollDirection = .vertical
        JsonCollectionView.register(UINib(nibName: "MyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Itemcell");
        loadData()
       
        
        /*guard let url = URL(string: "https://jsonplaceholder.typicode.com/photos") else {return}
        
        let task = URLSession.shared.dataTask(with: url){
            (data , response , error) in
            guard let dataResponse = data,
                error == nil else{
                    print(error?.localizedDescription ?? "Response error")
                    return}
            do{
                let JsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                print(JsonResponse)
            }catch let parsingError{
                print("Error", parsingError)
            }
        }
        task.resume()*/

        // Do any additional setup after loading the view.
    }
    

}
