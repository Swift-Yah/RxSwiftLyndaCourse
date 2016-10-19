//: Please build the scheme 'RxSwiftLyndaCourse' first

import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf("just") {
    let observable = Observable.just("Hello, world!")

    observable.subscribe({ (event: Event<String>) in
        print(event)
    })
}

exampleOf("of") {
    let observable = Observable.of(1, 2, 3)

    observable.subscribe({
        print($0)
    })

    observable.subscribe({
        print($0)
    })
}

// this was toObservable operator in Swift 2.2
exampleOf("from") {
    let disposeBag = DisposeBag()

    Observable.from([1, 2, 3]).subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)

    Observable.from([4, 5, 6]).subscribe(onCompleted: {
        print("Completed")
    }).addDisposableTo(disposeBag)
}

exampleOf("error") {
    enum RxError: Error {
        case test
    }

    Observable<Int>.error(RxError.test).subscribe({
        print($0)
    })
}
