//
//  GitHubController.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/23/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxCocoa
import RxSwift

final class GitHubController: UIViewController {
    @IBOutlet var tableView: UITableView!

    let disposeBag = DisposeBag()
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = GitHubViewModel()
}

// MARK: UIViewController functions

extension GitHubController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchController()
        setUpRx()
    }
}

// MARK: SearchController functions and computed variables

private extension GitHubController {
    var searchBar: UISearchBar {
        return searchController.searchBar
    }

    func setUpSearchController() {
        searchController.obscuresBackgroundDuringPresentation = false

        searchBar.showsCancelButton = true
        searchBar.text = "RafaelPlantard"
        searchBar.placeholder = "Enter GitHub ID, e.g., \"RafaelPlantard\""

        tableView.tableHeaderView = searchController.searchBar

        definesPresentationContext = true
    }
}

// MARK: Rx functions

private extension GitHubController {
    func setUpRx() {
        viewModel.data.drive(tableView.rx.items(cellIdentifier: "GitHubCellIdentifier")) { _, repository, cell in
            cell.textLabel?.text = repository.name
            cell.detailTextLabel?.text = repository.url
        }.addDisposableTo(disposeBag)

        searchBar.rx.text.bindTo(viewModel.searchText).addDisposableTo(disposeBag)

        searchBar.rx.cancelButtonClicked.map({ "" }).bindTo(viewModel.searchText).addDisposableTo(disposeBag)

        viewModel.data.map({ "\($0.count) Repositories" }).drive(navigationItem.rx.title).addDisposableTo(disposeBag)
    }
}
