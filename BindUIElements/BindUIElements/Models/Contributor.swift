//
//  Contributor.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/21/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import UIKit
import RxDataSources

struct Contributor {
    let name: String
    let gitHubID: String
    let image: UIImage?

    init(name: String, gitHubID: String) {
        self.name = name
        self.gitHubID = gitHubID
        self.image = {
            guard let image = UIImage(named: gitHubID.pascalCase) else { return #imageLiteral(resourceName: "GitHub") }

            return image
        }()
    }
}

// MARK: CustomStringConvertible conforms

extension Contributor: CustomStringConvertible {
    var description: String {
        return "\(name): https://github.com/\(gitHubID)"
    }
}

// MARK: IdentifiableType conforms

extension Contributor: IdentifiableType {
    typealias Identity = String

    var identity: Identity {
        return gitHubID
    }
}
