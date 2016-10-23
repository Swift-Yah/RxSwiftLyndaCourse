//: [Previous](@previous)

import PlaygroundSupport
import RxCocoa
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

exampleOf("retry:maxAttemptCount:") {
    let disposeBag = DisposeBag()

    var i = 1

    let sequenceThatErrors = Observable<Int>.create({
        $0.onNext(1)
        $0.onNext(2)

        if i < 5 {
            $0.onError(ReactiveXError.test)

            print("Error encountered")

            i += 1
        }

        $0.onNext(3)
        $0.onNext(4)

        $0.onCompleted()

        return NopDisposable.instance
    })

    sequenceThatErrors.retry(3).subscribe({ print($0) }).addDisposableTo(disposeBag)
}

exampleOf("Driver onErrorJustReturn") {
    let disposeBag = DisposeBag()

    let subject = PublishSubject<Int>()

    subject.asDriver(onErrorJustReturn: 1000).drive(onNext: { print($0) }).addDisposableTo(disposeBag)

    subject.onNext(1)
    subject.onNext(2)

    subject.onError(ReactiveXError.test)

    subject.onNext(3)
}

exampleOf("Driver onErrorDriveWith") {
    let disposeBag = DisposeBag()

    let subject = PublishSubject<Int>()
    let recoverySubject = PublishSubject<Int>()

    subject.asDriver(onErrorDriveWith: recoverySubject.asDriver(onErrorJustReturn: 1000)).drive(onNext: { print($0) }).addDisposableTo(disposeBag)

    subject.onNext(1)
    subject.onNext(2)

    subject.onError(ReactiveXError.test)

    subject.onNext(3)

    recoverySubject.onNext(10)
}

exampleOf("Driver onErrorRecover") {
    let disposeBag = DisposeBag()

    let subject = PublishSubject<Int>()

    subject.asDriver(onErrorRecover: {
        print("Error:", $0)

        return Driver.just(1000)
    }).drive(onNext: { print($0) }).addDisposableTo(disposeBag)

    subject.onNext(1)
    subject.onNext(2)

    subject.onError(ReactiveXError.test)
}

//: [Next](@next)
