//: [Previous](@previous)

import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf("doOnNext") {
    let disposeBag = DisposeBag()
    let fahrenheitTemperatures = Observable<Double>.from([-40, 0, 32, 70, 212])

    fahrenheitTemperatures
        .do(onNext: { $0 * $0 })
        .do(onNext: { print("\($0)ºF = ", terminator: "") })
        .map({ ($0 - 32) * 5/9 })
        .subscribe(onNext: { print(String(format: "%.1fºC", $0)) })
        .addDisposableTo(disposeBag)
}

//: [Next](@next)
