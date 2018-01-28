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
    var didFetchNextPage = false
    lazy var data: NSDictionary = NSDictionary()
    lazy var rootConnector: PropertyListConnector = {
        let entityGateway = InMemoryRepo(propertiesDictinary: data)
        return PropertyListConnector(entityGateway: entityGateway)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // we need to set in order to have smooth animation when fetching nextPage
        self.tableView!.rowHeight = UITableViewAutomaticDimension
        self.tableView!.estimatedRowHeight = 270
        
        loadingView.showLoadingView("Fetching Data", inViewController: self)
        // fetch the data before continuig
        JsonLoader.getJsonFrom(urlString: URLManager.sharedInstance.createURLWith(pageNumber: 0)) { (dict) in
            DispatchQueue.main.async {
                self.data = dict!
                self.rootConnector.assembleModule(view: self)
                self.presenter.viewReady()
                self.loadingView.hideLoadingView()
            }
        }
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
    
    // we calculate the diference between maxOffset and offset in order to figure out when are we reaching the end of the scroll
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let maxOffset = scrollView.contentSize.height - scrollView.frame.size.height
        // 270 is the row estimated height, by increasing this number we could fetch earlier
        if abs(maxOffset - offset) < 270 && !didFetchNextPage {
            print("Fetch next Page")
            didFetchNextPage = true
            fetchNextPage()
        }
    }
    
    func fetchNextPage() {
       presenter.fetchNextPage()
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
    
    func appendRows() {
        let indexPaths = (tableView.numberOfRows(inSection: 0)..<presenter.numberOfProperties).map { IndexPath(row: $0, section: 0) }
        tableView.beginUpdates()
        self.tableView.insertRows(at: indexPaths, with: .none )
         tableView.endUpdates()
        didFetchNextPage = false
    }
}
