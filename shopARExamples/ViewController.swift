//
//  ViewController.swift
//  shopARExamples
//
//  Created by Johan Todi on 2019-09-07.
//  Copyright © 2019 GFE. All rights reserved.
//

import UIKit
import shopAR

class ViewController: UIViewController {

    @IBAction func ShowPopUp(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "displayARObject") as? ARPopUpViewController
        {
            vc.url = fileUrl
            present(vc, animated: true, completion: nil)
        }
    }
    
    var fileUrl : String = ""
    
    override func viewDidLoad() {
        
        var shop = shopAR()
        print(shop.add(a: 3, b: 3))
        shop.fetchObject(user_id: "johan", file_id: "vase.scn") {
            myUrl in //(userID: "johan", objectID: "vase.scn")
            self.fileUrl = myUrl
            print(self.fileUrl)
        }
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

