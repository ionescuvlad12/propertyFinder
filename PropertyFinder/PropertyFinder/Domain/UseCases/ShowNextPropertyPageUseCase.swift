//
//  ShowNextPropertyPageUseCase.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

class ShowNextPropertyPageUseCase {
    
    // MARK: - Properties
    private let entityGateway: EntityGateway
    private let handler: MultiplePropertiesResponsesHandler
    let pageNumber:Int

    
    init(entityGateway: EntityGateway, pageNumber:Int, handler: MultiplePropertiesResponsesHandler) {
        self.entityGateway = entityGateway
        self.pageNumber = pageNumber
        self.handler = handler
    }
}

extension ShowNextPropertyPageUseCase: UseCase {
    func execute(completion: @escaping (Bool) -> Void) {
        let urlString = URLManager.sharedInstance.createURLWith(pageNumber: pageNumber)
        JsonLoader.getJsonFrom(urlString: urlString) { (dict) in
            if let dictionary = dict {
               let properties = self.entityGateway.appendNewPropertiesFrom(dict: dictionary)
                let response = properties.map { PropertyResponse(property: $0) }
                self.handler.appendMultiplePropertiesResponses(properties: response)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
