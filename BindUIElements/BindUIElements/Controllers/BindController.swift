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
    @IBOutlet var `switch`: UISwitch!
    @IBOutlet var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet var stepper: UIStepper!
    @IBOutlet var stepperLabel: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var datePickerLabel: UILabel!

    let dispose = DisposeBag()

    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()

        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        return formatter
    }()
}

