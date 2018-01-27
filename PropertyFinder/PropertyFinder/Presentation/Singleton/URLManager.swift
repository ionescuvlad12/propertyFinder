//
//  UrlFormatter.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

class URLManager {
    // ONE LINE SINGLETON
    static let sharedInstance = URLManager()
    
     var order:String = ""
    
    // MARK: - Initialize
    // prevent others from using the default '()'
    private init() {}
    
    func createURLWith(pageNumber:Int) -> String {
        var url = "https://www.propertyfinder.ae/mobileapi"
        if pageNumber > 0 && !order.isEmpty {
            url = url + "?page=\(pageNumber)&order=\(order)"
        } else if !order.isEmpty {
            url = url + "?order=\(order)"
        } else if pageNumber > 0{
            url = url + "?page=\(pageNumber)"
        }
        return url
    }
}
