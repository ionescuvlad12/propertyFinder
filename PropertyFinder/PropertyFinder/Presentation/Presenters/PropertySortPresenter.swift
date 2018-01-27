//
//  PropertySortPresenter.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation

class PropertySortPresenter {
    // MARK: - Properties
    
    weak var view: PropertySortView!
    private var useCaseFactory: UseCaseFactory
    
    // MARK: - Initializer
    
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    func sort(urlString: String, completion: @escaping () -> Void) {
        let useCase = useCaseFactory.sortPropertiesListUseCases(url: urlString)
        useCase.execute { (success) in
            if success {
                self.view.dismiss()
                completion()
            }
        }
    }
}
