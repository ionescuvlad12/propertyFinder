//
//  SortPropertyViewController.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import UIKit

class PropertySortViewController: UIViewController, UnwindSegueHandler {
    
    enum SortType:String {
        case priceDescinding = "pd"
        case priceAscending = "pa"
        case bedsDescending = "bd"
        case bedsAscending = "ba"
    }
    // MARK: - Parameters & Constants
    static let ID = "PropertySortViewController"
    enum UnwindSegueIdentifier: String {
        case toPropertyLists = "UnwindToPropertyList"
    }
    var sortType:SortType?
    
    // MARK: - Properties
    
    var presenter: PropertySortPresenter!
    var connector: PropertySortConnector!
    
    let loadingView = LoadingViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // we need a new back button because we will triger the sort on it
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PropertySortViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    // "Upon tapping one of the 4 sort option buttons and pressing back, the properties list should now be sorted in the order that was chosen."
    @objc func back(sender: UIBarButtonItem) {
        if let sortType = self.sortType {
            showLoadingView()
            URLManager.sharedInstance.order = sortType.rawValue
            let url = URLManager.sharedInstance.createURLWith(pageNumber: 0)
            presenter.sort(urlString: url) {
                self.loadingView.hideLoadingView()
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showLoadingView() {
        loadingView.showLoadingView("sorting stuff", inViewController: self)
    }
    
    @IBAction func priceDescending(_ sender: Any) {
        sortType = .priceDescinding
    }
    @IBAction func priceAscending(_ sender: Any) {
        sortType = .priceAscending
    }
    @IBAction func bedsDescending(_ sender: Any) {
        sortType = .bedsDescending
    }
    
    @IBAction func bedsAscending(_ sender: Any) {
        sortType = .bedsAscending
    }
}
extension PropertySortViewController: PropertySortView {
    func dismiss() {
        performSegue(withIdentifier: UnwindSegueIdentifier.toPropertyLists, sender: self)
    }
}
