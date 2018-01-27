//
//  UseCaseFactory.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

protocol MultiplePropertiesResponsesHandler: class {
    func handleMultiplePropertiesResponses(properties: [PropertyResponse])
}

class UseCaseFactory {
    
    // MARK: - Properties
    
    let entityGateway: EntityGateway
    
    
    // MARK: - Initializer
    
    init(entityGateway: EntityGateway) {
        self.entityGateway = entityGateway
    }
    
    // MARK: - Factory methods
    
    func showPropertiesListUseCase(handler: MultiplePropertiesResponsesHandler) -> UseCase {
        return ShowPropertiesListUseCase(entityGateway: entityGateway, handler: handler)
    }
    
    func sortPropertiesListUseCases(url:String) -> UseCase {
        return SortPropertyListUseCase(entityGateway: entityGateway, urlString: url)
    }
}
