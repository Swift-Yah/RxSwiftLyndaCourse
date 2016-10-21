//
//  Contributor.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/21/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit

struct Contributor {
    let name: String
    let gitHubID: String
    let image: UIImage?

    init(name: String, gitHubID: String) {
        self.name = name
        self.gitHubID = gitHubID

        image = UIImage(named: gitHubID.capitalized)
    }
}
