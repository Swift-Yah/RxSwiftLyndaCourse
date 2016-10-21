//
//  CollectionViewController.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/21/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit
import RxCocoa
import RxDataSources
import RxSwift

final class CollectionViewController: UIViewController {
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var addBarButtonItem: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!

    let disposeBag = DisposeBag()

    let dataSource = RxCollectionViewSectionedAnimatedDataSource<AnimatedSectionModel>()
    let data = Variable([
        AnimatedSectionModel(title: "Section: 0", data: ["0-0"])
                        ])
}

// MARK: UIViewController functions

extension CollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRx()
    }
}

// MARK: Private functions

private extension CollectionViewController {
    func setUpRx() {
        dataSource.configureCell = { _, collectionView, indexPath, title in
            guard let cell = collectionView
                .dequeueReusableCell(withReuseIdentifier: "CollectionCellIdentifier", for: indexPath) as? TitledCellView
                else { return TitledCellView() }

            cell.titleLabel.rx.text.onNext(title)

            return cell
        }

        dataSource.supplementaryViewFactory = { dataSource, collectionView, kind, indexPath in
            guard let header = collectionView
                .dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TitleHeaderIdentifier", for: indexPath)
            as? TitledHeaderView else { return TitledHeaderView() }

            let section = indexPath.section
            let data = dataSource.sectionModels[section]

            header.titleLabel.rx.text.onNext(data.title)

            return header
        }

        data.asDriver().drive(collectionView.rx.items(dataSource: dataSource)).addDisposableTo(disposeBag)
    }
}
