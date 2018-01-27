//
//  PropertySortConnector.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

class PropertySortConnector {
    
    // MARK: - Properties
    
    private let entityGateway: EntityGateway
    
    
    // MARK: - Initializer
    
    init(entityGateway: EntityGateway) {
        self.entityGateway = entityGateway
    }
    
    
    // MARK: - Dependency injection
    
    func assembleModule(view: PropertySortViewController) {
        let useCaseFactory = UseCaseFactory(entityGateway: entityGateway)
        let presenter = PropertySortPresenter(useCaseFactory: useCaseFactory)
        view.presenter = presenter
        view.connector = self
        presenter.view = view
    }
}
