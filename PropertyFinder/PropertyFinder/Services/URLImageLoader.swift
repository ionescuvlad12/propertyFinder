//
//  URLImageLoader.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation
import UIKit

class URLImageLoader {
    // function to load the image from URL
    static func getImageFrom(urlString: String) -> UIImage {
        do {
            if let url = URL(string:urlString) {
                let data = try Data(contentsOf: url)
                if let image = UIImage(data: data) {
                    return image
                } else {
                    // if there is no image return no image logo
                    return #imageLiteral(resourceName: "no-image-icon-1")
                }
            }
        }
        catch{
            print(error)
        }
        // if there is no image return no image logo
        return #imageLiteral(resourceName: "no-image-icon-1")
    }
}
