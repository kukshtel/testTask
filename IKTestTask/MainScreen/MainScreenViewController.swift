//
//  ViewController.swift
//  IKTestTask
//
//  Created by Kukshtel I. on 8/5/19.
//  Copyright © 2019 Kukshtel I. All rights reserved.
//

import UIKit

final class MainScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, MainScreenViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = MainScreenViewModel(networkService: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
    }
    
    // MARK: - SearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.query = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: - TableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainScreenTableViewCell
        return viewModel.setUpTableCell(cell: cell, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        return view
    }
    
    
    // MARK: - MainScreenViewControllerDelegate
    
    func dataDidLoad() {
        self.tableView.reloadData()
    }
    
}

