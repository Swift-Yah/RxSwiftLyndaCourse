//
//  ForwardViewModel.swift
//  BindUIElements
//
//  Created by Rafael Ferreira on 10/21/16.
//  Copyright © 2016 Swift Yah. All rights reserved.
//

import RxDataSources
import RxSwift

struct ForwardViewModel {
    let data = Observable.just([
        SectionModel(model: "A", items: [
            Contributor(name: "Alex V Bush", gitHubID: "alexvbush"),
            Contributor(name: "Ash Furrow", gitHubID: "ashfurrow")
        ]),
        SectionModel(model: "B", items: [
            Contributor(name: "Junior B.", gitHubID: "bontoJR")
        ]),
        SectionModel(model: "C", items: [
            Contributor(name: "Carlos García", gitHubID: "carlosypunto")
        ]),
        SectionModel(model: "D", items: [
            Contributor(name: "Jeon Suyeol", gitHubID: "devxoul")
        ]),
        SectionModel(model: "E", items: [
            Contributor(name: "Evgeny Aleksandrov", gitHubID: "ealeksandrov"),
            Contributor(name: "Esteban Torres", gitHubID: "esttorhe")
        ]),
        SectionModel(model: "F", items: [
            Contributor(name: "Karlo", gitHubID: "floskel"),
            Contributor(name: "Florent Pillet", gitHubID: "fpillet")
        ]),
        SectionModel(model: "G", items: [
            Contributor(name: "Guy Kahlon", gitHubID: "GuyKahlon")
        ]),
        SectionModel(model: "I", items: [
            Contributor(name: "Marin Todorov", gitHubID: "icanzilb"),
            Contributor(name: "Yongha Yoo", gitHubID: "inkyfox"),
            Contributor(name: "Yosuke Ishikawa", gitHubID: "ishkawa")
        ]),
        SectionModel(model: "K", items: [
            Contributor(name: "Krunoslav Zaher", gitHubID: "kzaher")
        ]),
        SectionModel(model: "L", items: [
            Contributor(name: "Laurin Brandner", gitHubID: "lbrndnr"),
            Contributor(name: "Leo Picado", gitHubID: "leopic"),
            Contributor(name: "Libor Huspenina", gitHubID: "libec"),
            Contributor(name: "Lukas Lipka", gitHubID: "lipka")
        ]),
        SectionModel(model: "M", items: [
            Contributor(name: "だいちろ", gitHubID: "mokumoku"),
            Contributor(name: "Hiroshi Kimura", gitHubID: "muukii")
        ]),
        SectionModel(model: "N", items: [
            Contributor(name: "Nathan Kot", gitHubID: "nathankot")
        ]),
        SectionModel(model: "O", items: [
            Contributor(name: "Orta", gitHubID: "orta")
        ]),
        SectionModel(model: "P", items: [
            Contributor(name: "Tomasz Pikć", gitHubID: "pikciu"),
            Contributor(name: "Chris Jimenez", gitHubID: "PiXeL16")
        ]),
        SectionModel(model: "S", items: [
            Contributor(name: "Scott Gardner", gitHubID: "scotteg"),
            Contributor(name: "Sendy Halim", gitHubID: "sendyhalim"),
            Contributor(name: "sergdort", gitHubID: "sergdort"),
            Contributor(name: "Spiros Gerokostas", gitHubID: "sger"),
            Contributor(name: "Bob Spryn", gitHubID: "sprynmr"),
            Contributor(name: "Łukasz Mróz", gitHubID: "sunshinejr")
        ]),
        SectionModel(model: "T", items: [
            Contributor(name: "Thane Gill", gitHubID: "thanegill")
        ]),
        SectionModel(model: "X", items: [
            Contributor(name: "xixi197 Nova", gitHubID: "xixi197")
        ])
    ])
}
