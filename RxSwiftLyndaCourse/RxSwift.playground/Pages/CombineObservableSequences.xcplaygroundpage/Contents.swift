//: [Previous](@previous)

import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf("startWith") {
    let disposeBag = DisposeBag()

    Observable.of("1", "2", "3")
        .startWith("A")
        .startWith("B")
        .startWith("C", "D")
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

exampleOf("merge") {
    let disposeBag = DisposeBag()

    let subjectOne = PublishSubject<String>()
    let subjectTwo = PublishSubject<String>()

    Observable.of(subjectOne, subjectTwo)
        .merge()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)

    subjectOne.onNext("A")
    subjectOne.onNext("B")

    subjectTwo.onNext("1")
    subjectTwo.onNext("2")

    subjectOne.onNext("C")
    subjectOne.onNext("3")
}

exampleOf("zip") {
    let disposeBag = DisposeBag()

    let stringSubject = PublishSubject<String>()
    let intSubject = PublishSubject<Int>()

    Observable.zip(stringSubject, intSubject) { stringElement, intElement in
        "\(stringElement) \(intElement)"
        }
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)

    stringSubject.onNext("A")
    stringSubject.onNext("B")

    intSubject.onNext(1)
    intSubject.onNext(2)

    intSubject.onNext(3)
    stringSubject.onNext("C")
}

//: [Next](@next)
