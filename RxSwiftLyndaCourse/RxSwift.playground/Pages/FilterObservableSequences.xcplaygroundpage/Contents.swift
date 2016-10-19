//: [Previous](@previous)

import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf("filter") {
    let disposeBag = DisposeBag()
    let numbers = Observable.generate(initialState: 1, condition: { $0 < 101 }, iterate: { $0 + 1 })

    numbers.filter({ number in
        guard number > 1 else { return false }

        var isPrime = true

        (2 ..< number).forEach({
            if number % $0 == 0 {
                isPrime = false
            }
        })

        return isPrime
    })
    .toArray()
    .subscribe(onNext: { print($0) })
    .addDisposableTo(disposeBag)
}

exampleOf("distinctUntilChanged") {
    let disposeBag = DisposeBag()
    let searchString = Variable("")

    searchString.asObservable()
        .map({ $0.lowercased() })
        .distinctUntilChanged()
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)

    searchString.value = "APPLE"
    searchString.value = "Apple"
    searchString.value = "apple"
    searchString.value = "Banana"
    searchString.value = "APPLE"
}

exampleOf("takeWhile") {
    let disposeBag = DisposeBag()

    Observable.from([0, 1, 2, 3, 4, 3, 2, 1, 0])
        .takeWhile({ $0 < 4 })
        .subscribe(onNext: { print($0) })
        .addDisposableTo(disposeBag)
}

//: [Next](@next)
