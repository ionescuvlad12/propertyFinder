//
//  PropertyListView.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation


protocol PropertyListView: class {
    func refresh()
    func navigateToSortPropery()
    func appendRows()
}
