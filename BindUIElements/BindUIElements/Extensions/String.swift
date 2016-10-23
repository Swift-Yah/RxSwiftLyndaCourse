//
//  String.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/23/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

extension String {
    var first: String {
        let item = characters.prefix(1)

        return String(item)
    }

    var last: String {
        let array = characters.dropFirst()

        return String(array)
    }

    var pascalCase: String {
        return first.uppercased() + last
    }
}
