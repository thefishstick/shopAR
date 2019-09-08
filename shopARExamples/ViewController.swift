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
    
    @IBOutlet weak var ar1: UIButton!
    @IBOutlet weak var ar2: UIButton!
    @IBOutlet weak var ar3: UIButton!
    @IBOutlet weak var ar4: UIButton!
    @IBOutlet weak var ar5: UIButton!
    @IBOutlet weak var ar6: UIButton!
    @IBOutlet weak var ar7: UIButton!
    @IBOutlet weak var ar8: UIButton!
    
    @IBOutlet weak var scroller: UIScrollView!
    
    var ararray : [UIButton] = []
    let user_id = "johan"
    let file_ids = ["chair.scn", "candle.scn", "vase.scn", "shoes.scn", "lamp.scn", "cup.scn", "vase.scn", "vase.scn"]
    
    var urls : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //create refresh control for scroll view
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scroller.refreshControl = refreshControl
        
        // Define array of products on page
        self.ararray = [ar1, ar2, ar3, ar4, ar5, ar6, ar7, ar8]
        self.loadObjects()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func loadObjects(){
        // Initialize shopAR
        var shop = shopAR()
        
        // For each file_id in array, fetch its url in s3
        for i in 0...(self.file_ids.count - 1) {
            shop.fetchObject(user_id: self.user_id, file_id: self.file_ids[i]) {
                returnedUrl in
                
                // Save this file's url
                self.urls.append(returnedUrl)
                
                // Set button tag
                DispatchQueue.main.async{
                    self.ararray[i].tag = i
                    
                    // If url was found in s3, unhide view-AR button
                    if returnedUrl != "no-url-found" {
                        self.ararray[i].isHidden = false
                        self.ararray[i].isEnabled = true
                        
                        // Set selecter action for active button
                        self.ararray[i].addTarget(self,action:#selector(self.buttonClicked),
                                                  for:.touchUpInside)
                        
                    } else {
                        self.ararray[i].isHidden = true
                        self.ararray[i].isEnabled = false
                    }
                }
            }
        }
        
    }
    
    @objc func refresh(refreshControl: UIRefreshControl) {
 
        //reload items on refresh
        self.loadObjects()
        refreshControl.endRefreshing()
    }
    
    
    
    
    // Function called when view-AR button is pressed
    @objc func buttonClicked(sender:UIButton)
    {
        // Get selected url
        let url = self.urls[sender.tag]
        
        // Present ARPopUpVC with selected url
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "displayARObject") as? ARPopUpViewController
        {
            vc.url = url
            present(vc, animated: true, completion: nil)
        }
    }


}

