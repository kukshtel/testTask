//
//  MainScreenViewModel.swift
//  IKTestTask
//
//  Created by Kukshtel I. on 8/5/19.
//  Copyright © 2019 Kukshtel I. All rights reserved.
//

import UIKit
import SDWebImage

protocol MainScreenViewControllerDelegate: class {
    func dataDidLoad()
}

final class MainScreenViewModel {
    
    weak var delegate: MainScreenViewControllerDelegate?
    private let networkService: NetworkServiceProtocol
    
    private(set) var resultsArray: [ITunesStoreModel] = [] {
        didSet {
            self.delegate?.dataDidLoad()
        }
    }
    
    var query: String = "" {
        didSet {
            updateResults(forSearchRequest: query)
        }
    }
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    private func updateResults(forSearchRequest text: String) {
        if text != "" {
            networkService.searchRequest(text: text) { resultArray in
                self.resultsArray = resultArray
            }
        } else {
            resultsArray = [ITunesStoreModel]()
        }
    }
    
    func setUpTableCell(cell: MainScreenTableViewCell, for indexPath: IndexPath) -> MainScreenTableViewCell {
        cell.firstLabel.text = resultsArray[indexPath.row].name
        cell.secondLabel.text = resultsArray[indexPath.row].kind

        let imageUrl = URL(string: resultsArray[indexPath.row].imageUrl)
        cell.icon.sd_setImage(with: imageUrl, completed: nil)

        return cell
    }
    
}
