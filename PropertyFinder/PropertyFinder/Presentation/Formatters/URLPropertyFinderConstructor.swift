//
//  UrlFormatter.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

class URLPropertyFinderConstructor {
    
     static func createURL(withOrder order:String?, andPageNumber pageNumber:Int) -> String {
        var url = "https://www.propertyfinder.ae/mobileapi"
        if pageNumber > 0 && order != nil {
            url = url + "?page=\(pageNumber)&order=\(order!)"
        } else if order != nil {
            url = url + "?order=\(order!)"
        } else if pageNumber > 0{
            url = url + "?page=\(pageNumber)"
        }
        return url
    }
}
