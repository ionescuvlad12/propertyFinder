//
//  PropertyListItemView.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation
import UIKit
protocol PropertyListItemView {
    func display(thumbnailImage: UIImage)
    func display(price: Double)
    func display(beds: Int)
}
