//
//  ShowPropertiesUseCase.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

class ShowPropertiesListUseCase {
    //MARK: - Properties
    private let entityGateway: EntityGateway
    private weak var handler: MultiplePropertiesResponsesHandler?
    
    // MARK: - Initializer
    init(entityGateway: EntityGateway, handler: MultiplePropertiesResponsesHandler) {
        self.entityGateway = entityGateway
        self.handler = handler
    }
}
extension ShowPropertiesListUseCase: UseCase {
    func execute() {
        let properties = entityGateway.fetchProperties()
        let response = properties.map { PropertyResponse(property: $0) }
        handler?.handleMultiplePropertiesResponses(properties: response)
    }
}
