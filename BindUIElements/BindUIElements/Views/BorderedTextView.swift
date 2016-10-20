//
//  BorderedTextView.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/20/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIColor_Hex_Swift
import UIKit

final class BorderedTextView: UITextView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setUpUI()
    }

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        setUpUI()
    }
}

// MARK: Private functions

private extension BorderedTextView {
    func setUpUI() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor("#CCC").cgColor
        layer.cornerRadius = 5
    }
}
