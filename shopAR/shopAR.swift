//
//  shopAR.swift
//  shopAR
//
//  Created by Johan Todi on 2019-09-07.
//  Copyright © 2019 GFE. All rights reserved.
//

import Foundation

public final class shopAR {
    let name = "shopAR"
    
    public func add(a: Int, b: Int) -> Int{
        return a + b
    }
    
    public func sub(a: Int, b: Int) -> Int{
        return a - b
    }
    
    
    func fetchObject(userID: String, objectID: String) -> String{
        var final_response = "no-url-found"
        let parameters = ["user_id": userID, "file_id": objectID]
        
        //create the url with URL
        let url = URL(string: "https://shoppar.herokuapp.com/api/getObject")!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            return final_response
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    let final_url = json["url"] as! String
                    final_response = final_url
                    return

                }
            } catch let error {
                print(error.localizedDescription)
                return
            }
        })
        
        task.resume()
        return final_response
        
    }
    
    
    
    
    
    
    public init() {}
}
