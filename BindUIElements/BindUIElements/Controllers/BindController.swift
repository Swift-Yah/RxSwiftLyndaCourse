//
//  BindController.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/20/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class BindController: UIViewController {
    @IBOutlet var tapGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet var textField: UITextField!
    @IBOutlet var textFieldLabel: UILabel!
    @IBOutlet var textView: BorderedTextView!
    @IBOutlet var textViewLabel: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var buttonLabel: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var segmentedControlLabel: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var uiSwitch: UISwitch!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var stepperLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var datePickerLabel: UILabel!

    let disposeBag = DisposeBag()

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        return formatter
    }()
}

// MARK: UIViewController functions

extension BindController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpRx()
    }
}

// MARK: Private functions

private extension BindController {
    func setUpRx() {
        tapGestureRecognizer.rx.event.asDriver().drive(onNext: { [unowned self] _ in
            self.view.endEditing(true)
        }).addDisposableTo(disposeBag)

        textField.rx.text.asDriver().drive(textFieldLabel.rx.text).addDisposableTo(disposeBag)

        // Using driveNext
//        textField.rx.text.asDriver().drive(onNext: { [unowned self] in
//            self.textFieldLabel.text = $0
//        }).addDisposableTo(disposeBag)

        // Using bindTo
//        textField.rx.text.bindTo(textFieldLabel.rx.text).addDisposableTo(disposeBag)

        textView.rx.text.asObservable().bindNext({ [unowned self] in
            self.textViewLabel.rx.text.onNext("Character count: \($0!.characters.count)")
//            self.textViewLabel.text = "Character count: \($0!.characters.count)"
        }).addDisposableTo(disposeBag)

        button.rx.tap.asDriver().drive(onNext: { [unowned self] _ in
            self.buttonLabel.text! += "Tapped! "
            self.view.endEditing(true)

            UIView.animate(withDuration: 0.35) {
                self.view.layoutIfNeeded()
            }
        }).addDisposableTo(disposeBag)
    }
}

