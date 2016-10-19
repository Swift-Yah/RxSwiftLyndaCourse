//: [Previous](@previous)

import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf("PublishSubject") {
    let disposeBag = DisposeBag()
    let subject = PublishSubject<String>()

    subject.subscribe({
        print($0)
    }).addDisposableTo(disposeBag)

    enum RxError: Error {
        case test
    }

    subject.on(.next("Hello"))

//    subject.onCompleted()
//    subject.onError(RxError.test)

    subject.onNext("World")

    let newSubscription = subject.subscribe(onNext: {
        print("New subscription: ", $0)
    })

    subject.onNext("What's up")

    newSubscription.dispose()

    subject.onNext("Still there?")
}

exampleOf("BehaviorSubject") {
    let disposeBag = DisposeBag()
    let subject = BehaviorSubject(value: "a")

    subject.subscribe(onNext: {
        print(#line, $0)
    }).addDisposableTo(disposeBag)

    subject.onNext("b")

    subject.subscribe(onNext: {
        print(#line, $0)
    }).addDisposableTo(disposeBag)
}

exampleOf("ReplaySubject") {
    let disposeBag = DisposeBag()
    let subject = ReplaySubject<Int>.create(bufferSize: 3)

    subject.onNext(1)
    subject.onNext(2)
    subject.onNext(3)
    subject.onNext(4)

    subject.subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)
}

exampleOf("Variable") {
    let disposeBag = DisposeBag()
    let subject = Variable("A")

    subject.asObservable().subscribe(onNext: {
        print($0)
    }).addDisposableTo(disposeBag)

    subject.value = "B"
}

//: [Next](@next)
