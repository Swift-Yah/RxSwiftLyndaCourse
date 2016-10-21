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
import SwiftRandom

final class CollectionViewController: UIViewController {
    @IBOutlet var longPressGestureRecognizer: UILongPressGestureRecognizer!
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

        addBarButtonItem.rx.tap.asDriver().drive(onNext: { [unowned self] in
            let sectionNumber = self.data.value.count
            let section = "Section: \(sectionNumber)"

            let items: [String] = {
                var items = [String]()
                let numberOfItems = Int.random(0, 6)

                (0 ..< numberOfItems).forEach({
                    let currentItem = "\(sectionNumber)-\($0)"

                    items.append(currentItem)
                })

                return items
            }()

            let data = AnimatedSectionModel(title: section, data: items)

            self.data.value += [data]
        }).addDisposableTo(disposeBag)

        longPressGestureRecognizer.rx.event.subscribe(onNext: { [unowned self] in
            switch $0.state {
            case .began:
                let point = $0.location(in: self.collectionView)

                guard let indexPath = self.collectionView.indexPathForItem(at: point) else { break }

                self.collectionView.beginInteractiveMovementForItem(at: indexPath)

            case .changed:
                guard let view = $0.view else { break }

                let point = $0.location(in: view)

                self.collectionView.updateInteractiveMovementTargetPosition(point)

            case .ended:
                self.collectionView.endInteractiveMovement()

            default:
                self.collectionView.cancelInteractiveMovement()
            }
        }).addDisposableTo(disposeBag)
    }
}
