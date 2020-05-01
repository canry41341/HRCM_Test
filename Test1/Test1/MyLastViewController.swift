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
        let imageUrl = NSURL(string: ImageString)
        let imageData = NSData(contentsOf: imageUrl!  as URL)
        
        if(imageData != nil){
           MyLastIMG.image = UIImage(data: imageData! as Data)
            MyLastIMG.contentMode = .scaleAspectFit
        
        }
        
        MyLastID.text = "ID: " + self.verificationId
        MyLastTitles.text = self.verificationTitle
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
