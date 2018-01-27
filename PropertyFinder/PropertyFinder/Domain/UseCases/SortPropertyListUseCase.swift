//
//  SortPropertyListUseCase.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

class SortPropertyListUseCase {
    // MARK: - Properties
    
    private let entityGateway: EntityGateway
    private let urlString:String
    // MARK: - Initializer
    
    init(entityGateway: EntityGateway, urlString:String) {
        self.entityGateway = entityGateway
        self.urlString = urlString
    }
}

extension SortPropertyListUseCase: UseCase {
    func execute(completion: @escaping (Bool) -> Void) {
        JsonLoader.getJsonFrom(urlString: urlString) { (dict) in
            self.entityGateway.sortProperties(with: dict!)
            completion(true)
        }
    }
}
