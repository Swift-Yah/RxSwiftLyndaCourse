//: [Previous](@previous)

import Async
import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

func sampleWithPublish() {
    let disposeBag = DisposeBag()
    let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()

    observable.debug("1st").subscribe({ _ in })

    Async.main(after: 2) {
        observable.connect()
    }

    Async.main(after: 4 ) {
        observable.debug("2nd").subscribe({ _ in }).addDisposableTo(disposeBag)
    }
}

// un-comment below to see how debug and Observable.interval works
//sampleWithPublish()

// Resource count is disabled by default, here it is instructions to enable it in CocoaPods: https://github.com/ReactiveX/RxSwift/issues/378

exampleOf("Resources.total") {
    print(Resources.total)

    let disposeBag = DisposeBag()

    print(Resources.total)

    let observable = Observable.just("Hello, World!")

    print(Resources.total)

    observable.subscribe(onNext: { _ in
        print(Resources.total)
    }).addDisposableTo(disposeBag)

    print(Resources.total)
}

print(Resources.total)

//: [Next](@next)
