//: [Previous](@previous)

import PlaygroundSupport
//import RxCocoa
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf("catchErrorJustReturn") {
    let disposeBag = DisposeBag()
    let sequenceThatFails = PublishSubject<String>()

    sequenceThatFails.catchErrorJustReturn("😎").subscribe({ print($0) }).addDisposableTo(disposeBag)

    sequenceThatFails.onNext("Hello")
    sequenceThatFails.onNext("World")
    sequenceThatFails.onError(ReactiveXError.test)
}

exampleOf("catchError") {
    let sequenceThatFails = PublishSubject<String>()
    let recoverySequence = PublishSubject<String>()

    sequenceThatFails.catchError({
        print("Error: ", $0)

        return recoverySequence
    }).subscribe({ print($0) })

    sequenceThatFails.onNext("Hello")
    sequenceThatFails.onNext("Again")
    sequenceThatFails.onError(ReactiveXError.test)
    sequenceThatFails.onNext("Still there?")

    recoverySequence.onNext("Don't worry, I've got this!")
}

exampleOf("retry") {
    let disposeBag = DisposeBag()

    var i = 1

    let sequenceThatErrors = Observable<Int>.create({
        $0.onNext(1)
        $0.onNext(2)

        if i == 1 {
            $0.onError(ReactiveXError.test)

            print("Error encountered")

            i += 1
        }

        $0.onNext(3)
        $0.onNext(4)
        $0.onCompleted()

        return NopDisposable.instance
    })

    sequenceThatErrors.retry().subscribe({ print($0)}).addDisposableTo(disposeBag)
}

//: [Next](@next)
