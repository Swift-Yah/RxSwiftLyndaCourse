//
//  TableViewController.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/21/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class TableViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    let data = Observable.just([
        Contributor(name: "Krunoslav Zaher", gitHubID: "kzaher"),
        Contributor(name: "Yury Korolev", gitHubID: "yury"),
        Contributor(name: "Mohsenr", gitHubID: "mohsenr"),
        Contributor(name: "Scott Gardner", gitHubID: "scotteg"),
        Contributor(name: "Serg Dort", gitHubID: "sergdort"),
        Contributor(name: "Carlos García", gitHubID: "carlosypunto"),
        Contributor(name: "Junior B.", gitHubID: "bontoJR"),
        Contributor(name: "Jesse Farless", gitHubID: "solidcell"),
        Contributor(name: "Jamie Pinkham", gitHubID: "jamiepinkham"),
        Contributor(name: "Thane Gill", gitHubID: "thanegill")
                               ])

    let disposeBag = DisposeBag()
}

// MARK: UIViewController functions

extension TableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRx()
    }
}

// MARK: Private functions

private extension TableViewController {
    func setUpRx() {
        data.bindTo(tableView.rx.items(cellIdentifier: "TableCellIdentifier")) { _, contributor, cell in
            cell.textLabel?.text = contributor.name
            cell.detailTextLabel?.text = contributor.gitHubID
            cell.imageView?.image = contributor.image
        }.addDisposableTo(disposeBag)

        tableView.rx.modelSelected(Contributor.self).subscribe(onNext: {
            print("You selected \($0)")
        }).addDisposableTo(disposeBag)

        tableView.rx.itemSelected.asDriver().drive(onNext: { [unowned self] in
            self.tableView.deselectRow(at: $0, animated: true)
        }).addDisposableTo(disposeBag)
    }
}
