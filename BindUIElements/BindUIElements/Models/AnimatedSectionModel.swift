//
//  AnimatedSectionModel.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/21/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxDataSources

struct AnimatedSectionModel {
    let title: String
    var data: [String]
}

extension AnimatedSectionModel: AnimatableSectionModelType {
    typealias Identity = String
    typealias Item = String

    var identity: Identity {
        return title
    }

    var items: [Item] {
        return data
    }

    init(original: AnimatedSectionModel, items: [Item]) {
        self = original
        data = items
    }
}
