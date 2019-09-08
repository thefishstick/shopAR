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
    
    
    public func fetchObject(user_id: String, file_id: String, completionHandler: @escaping (_ myUrl: String) -> ()) {
        // Object parameters in s3
        let parameters = ["user_id": user_id, "file_id": file_id]
        
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
        }
        
        // Request formatting
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data else {
                return
            }
            
            do {
                // Jsonify request
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    
                    // Retrieve url from request response, and mark completion
                    let final_url = json["url"] as! String
                    completionHandler(final_url)
                    
                }
            } catch let error {
                print(error.localizedDescription)
                // Response did not provie a url
                completionHandler("no-url-found")
            }
        }
        task.resume()
    }

    
    public init() {}
    
}
