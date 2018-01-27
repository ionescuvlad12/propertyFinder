//
//  EntityGateway.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

protocol EntityGateway {
    func fetchProperties() -> [Property]
    func sortProperties(with dict: NSDictionary)
    func appendNewPropertiesFrom(dict: NSDictionary) -> [Property]
}
