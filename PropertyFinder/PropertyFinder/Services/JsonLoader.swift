//
//  JsonLoader.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation
class JsonLoader {
    //this function is fetching the json from URL
    static func getJsonFrom(urlString:String, completion: @escaping (_ result: NSDictionary?) -> Void) {
        //creating a NSURL
        var dict:NSDictionary?
        let url = NSURL(string: urlString)
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: (url as URL?)!, completionHandler: {(data, response, error) -> Void in
            
            if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                
                //printing the json in console
                print(jsonObj as Any)
               dict = jsonObj
                completion(dict)
            }
        }).resume()
    }
}
