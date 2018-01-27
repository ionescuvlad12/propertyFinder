//
//  PropertyListPresenter.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import Foundation


class PropertyListPresenter {
    private let useCaseFactory: UseCaseFactory
    // we can force unrwrap here becoase the presenter should never have the view nil
    weak var view: PropertyListView!
    var numberOfProperties: Int {
        return properties.count
    }
    private var properties = [PropertyResponse]()
    var selectedId: String?
    
    
    // MARK: - Initializers
    init(useCaseFactory: UseCaseFactory) {
        self.useCaseFactory = useCaseFactory
    }
    
    // MARK: - Events
    func viewReady() {
        executeShowPropertiesListUseCase()
    }
    
    private func executeShowPropertiesListUseCase() {
        let useCase = useCaseFactory.showPropertiesListUseCase(handler: self)
        useCase.execute()
    }
    
    func configure(cell: PropertyListItemView, forRow row: Int) {
        let property = properties[row]
        cell.display(thumbnailImage: property.thumbnailImage)
        cell.display(beds: property.beds)
        cell.display(price: property.price)
    }
    
    func sortButtonTapped() {
        
    }
    
    func dataChanged() {
        executeShowPropertiesListUseCase()
    }
}

extension PropertyListPresenter: MultiplePropertiesResponsesHandler {
    func handleMultiplePropertiesResponses(properties: [PropertyResponse]) {
        self.properties = properties
        view.refresh()
    }
}
