//
//  GitHubViewModel.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/23/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

struct GitHubViewModel {
    let disposeBag = DisposeBag()
    let searchText = Variable("")

    var data: Driver<[Repository]> {
        return searchText.asObservable().throttle(0.35, scheduler: MainScheduler.instance).distinctUntilChanged()
            .flatMapLatest({ self.getRepositories($0) }).asDriver(onErrorJustReturn: [])
    }

    func getRepositories(_ gitHubID: String) -> Observable<[Repository]> {
        guard !gitHubID.isEmpty, let url = URL(string: "https://api.github.com/users/\(gitHubID)/repos") else {
            return Observable.just([])
        }

        return URLSession.shared.rx.JSON(url)
            .retry(3)
            .map({
                var repositories = [Repository]()

                if let items = $0 as? [[String: AnyObject]] {
                    items.forEach({
                        guard let name = $0["name"] as? String, let url = $0["html_url"] as? String else { return }

                        let repository = Repository(name: name, url: url)

                        repositories.append(repository)
                    })
                }

                return repositories
            })
    }
}
