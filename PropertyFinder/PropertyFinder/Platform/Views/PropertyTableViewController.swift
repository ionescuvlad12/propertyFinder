//
//  PropertyTableViewController.swift
//  PropertyFinder
//
//  Created by Ionescu Vlad on 27/01/2018.
//  Copyright © 2018 Ionescu Vlad. All rights reserved.
//

import UIKit

class PropertyTableViewController: UITableViewController, SegueHandler {
    
    //MARK: -Constants
    static let ID = "PropertyTableViewController"
    enum SegueIdentifier: String {
        case sortProperty = "SortProperty"
    }

    // MARK: - Properties
    // we can force unrwap here because the view controllers should never have the presenter or the connector nil.
    var presenter: PropertyListPresenter!
    var connector: PropertyListConnector!
    
    let loadingView = LoadingViewController()
    @IBOutlet weak var sortButton: UIBarButtonItem!
    
    lazy var data: NSDictionary = NSDictionary()
    lazy var rootConnector: PropertyListConnector = {
        let entityGateway = InMemoryRepo(propertiesDictinary: data)
        return PropertyListConnector(entityGateway: entityGateway)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.showLoadingView("Fetching Data", inViewController: self)
        JsonLoader.getJsonFrom(urlString: URLPropertyFinderConstructor.createURL(withOrder: nil, andPageNumber: 0)) { (dict) in
            DispatchQueue.main.async {
                self.data = dict!
                self.rootConnector.assembleModule(view: self)
                self.presenter.viewReady()
                self.loadingView.hideLoadingView()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        sortButton.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - UI Actions
    
    @IBAction func sort(_ sender: UIBarButtonItem) {
        presenter.sortButtonTapped()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (presenter != nil) {
            return presenter.numberOfProperties
        } else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyTableViewCell.ID, for: indexPath) as! PropertyTableViewCell
        presenter.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
    
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = try! segueIdentifier(for: segue)
        switch identifier {
        case .sortProperty: connector.navigateToSortProperty(viewController: segue.destination)
        }
    }
    
    // MARK: Unwinds
    
    @IBAction func unwindToPropertyList(segue: UIStoryboardSegue) {
        presenter.dataChanged() }
    
    
}
extension PropertyTableViewController: PropertyListView {
    func navigateToSortPropery() {
        performSegue(withIdentifier: SegueIdentifier.sortProperty, sender: self)
    }
    
    func refresh() {
        tableView.reloadData()
    }
}
