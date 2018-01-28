//
//  EntityGatewayTestDummy.swift
//  PropertyFinderTests
//
//  Created by Ionescu Vlad on 28/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

@testable import PropertyFinder


class EntityGatewayTestDummy: EntityGateway {
    func fetchProperties() -> [Property] {
        return []
    }
    
    func sortProperties(with dict: NSDictionary) {
        
    }
    
    func appendNewPropertiesFrom(dict: NSDictionary) -> [Property] {
        return []
    }
}

