//
//  DataController.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/21/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class DataController: UIViewController {
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var textField: UITextField!
    @IBOutlet var button: UIButton!

    let disposeBag = DisposeBag()
    let text = Variable("")
    let buttonTapped = PublishSubject<String>()
}

// MARK: UIViewController functions

extension DataController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRx()
    }
}

// MARK: Private functions

private extension DataController {
    func setUpRx() {
        tapGestureRecognizer.rx.event.asDriver().drive(onNext: { [unowned self] _ in
            self.view.endEditing(true)
        }).addDisposableTo(disposeBag)

        textField.rx.text.orEmpty.bindTo(text).addDisposableTo(disposeBag)

        text.asObservable().subscribe(onNext: { print($0) }).addDisposableTo(disposeBag)

        button.rx.tap.map({ "Tapped! " }).bindTo(buttonTapped).addDisposableTo(disposeBag)

        buttonTapped.subscribe(onNext: { print($0) }).addDisposableTo(disposeBag)
    }
}
