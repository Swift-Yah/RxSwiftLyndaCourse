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
import SwiftRandom

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

        let valueOnError = IndexPath(row: 0, section: 0)

        tableView.rx.itemSelected
            .flatMapLatest({ Observable.just($0).delaySubscription(0.35, scheduler: MainScheduler.instance) })
            .asDriver(onErrorJustReturn: valueOnError).drive(onNext: { [unowned self] in
                self.tableView.deselectRow(at: $0, animated: true)
            }).addDisposableTo(disposeBag)

        viewModel.data.bindTo(tableView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)

        tableView.rx.setDelegate(self).addDisposableTo(disposeBag)
    }
}

// MARK: UITableViewDelegate conforms

extension ForwardController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat.random(32, 128)
    }
}


