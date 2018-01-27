//
//  PropertyListConnector.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import UIKit


class PropertyListConnector {
    // MARK: - Parameters & Constants
    
    // MARK: - Properties
    
    private let entityGateway: EntityGateway
    
    // MARK: - Initializer
    
    init(entityGateway: EntityGateway) {
        self.entityGateway = entityGateway
    }
    
    
    // MARK: - Dependency injection
    
    func assembleModule(view: PropertyTableViewController) {
        let useCaseFactory = UseCaseFactory(entityGateway: entityGateway)
        let presenter = PropertyListPresenter(useCaseFactory: useCaseFactory)
        view.presenter = presenter
        view.connector = self
        presenter.view = view
    }
}

