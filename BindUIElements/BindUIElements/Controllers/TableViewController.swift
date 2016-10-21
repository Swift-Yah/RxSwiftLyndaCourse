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

    let data = [
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
    ]
}

// MARK: UITableDataSource conforms

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCellIdentifier") else {
            return UITableViewCell()
        }

        let contributor = data[indexPath.row]

        cell.textLabel?.text = contributor.name
        cell.detailTextLabel?.text = contributor.gitHubID
        cell.imageView?.image = contributor.image

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
}

// MARK: UITableViewDelegate conforms

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contributor = data[indexPath.row]

        print("You selected: \(contributor)")

        UIView.animate(withDuration: 0.70) {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
