//
//  ForwardController.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/21/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

final class ForwardController: UIViewController {
    @IBOutlet var tableView: UITableView!

    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Contributor>>()
    let disposeBag = DisposeBag()
    let viewModel = ForwardViewModel()
}

// MARK: UIViewController functions

extension ForwardController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRx()
    }
}

// MARK: Private functions

private extension ForwardController {
    func setUpRx() {
        dataSource.configureCell = { _, tableView, indexPath, contributor in
            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellIdentifier", for: indexPath)

            cell.textLabel?.text = contributor.name
            cell.detailTextLabel?.text = contributor.gitHubID
            cell.imageView?.image = contributor.image

            return cell
        }

        dataSource.titleForHeaderInSection = {
            let item = $0.sectionModels[$1]

            return item.identity
        }

        viewModel.data.bindTo(tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
    }
}
