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
    var pageNumber: Int = 0
    
    private var properties = [PropertyResponse]()
    
    
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
        useCase.execute { (success) in }
    }
    
    func configure(cell: PropertyListItemView, forRow row: Int) {
        let property = properties[row]
        cell.display(thumbnailImage: property.thumbnailImage)
        cell.display(beds: property.beds)
        cell.display(price: property.price)
    }
    
    func sortButtonTapped() {
        view.navigateToSortPropery()
    }
    
    func dataChanged() {
        executeShowPropertiesListUseCase()
    }
    
    func fetchNextPage() {
        // increase the page number
        pageNumber = pageNumber + 1
        let useCase = useCaseFactory.showNextPage(pageNumber: pageNumber, handler: self)
        useCase.execute { (success) in}
    }
}

extension PropertyListPresenter: MultiplePropertiesResponsesHandler {
    func appendMultiplePropertiesResponses(properties: [PropertyResponse]) {
        self.properties.append(contentsOf: properties)
        DispatchQueue.main.async {
            self.view.appendRows()
        }
    }
    
    func handleMultiplePropertiesResponses(properties: [PropertyResponse]) {
        self.properties = properties
        DispatchQueue.main.async {
            if self.view != nil {
                self.view.refresh()
            }
        }
    }
}
