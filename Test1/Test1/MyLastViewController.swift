//
//  MyLastViewController.swift
//  Test1
//
//  Created by mac  on 2020/5/1.
//  Copyright © 2020年 appCoda. All rights reserved.
//

import UIKit

class MyLastViewController: UIViewController {
    
    @IBOutlet weak var MyLastIMG: UIImageView!
    @IBOutlet weak var MyLastTitles: UILabel!
    @IBOutlet weak var MyLastID: UILabel!
    var verificationId: String = ""
    var verificationTitle: String = ""
    var verificationURL: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let ImageString = self.verificationURL
        let imageUrl = NSURL(string: ImageString)//parsing images via URLSession
            DispatchQueue.global(qos: .background).async {
                URLSession.shared.dataTask(with: imageUrl! as URL) { (data, response, error) in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.MyLastIMG.image = image
                            self.MyLastID.text = "ID: " + self.verificationId
                            self.MyLastTitles.text = self.verificationTitle
                            
                        }
                    } else {
                    }
                }.resume()
                
            }
            
        }

}
