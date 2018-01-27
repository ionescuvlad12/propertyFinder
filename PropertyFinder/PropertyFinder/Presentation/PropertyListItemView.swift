//
//  PropertyListItemView.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

protocol PropertyListItemView {
    func display(thumbnailUrl: String)
    func display(price: Double)
    func display(beds: Int)
}
