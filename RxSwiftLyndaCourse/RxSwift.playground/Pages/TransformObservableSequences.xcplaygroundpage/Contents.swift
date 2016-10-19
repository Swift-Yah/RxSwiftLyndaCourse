//: [Previous](@previous)

import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

exampleOf("map") {
    Observable.of(1, 2, 3)
        .map({ $0 * $0 })
        .subscribe(onNext: { print($0) })
        .dispose()
}

exampleOf("flatMap & flatMapLatest") {
    let disposeBag = DisposeBag()

    struct Player {
        let score: Variable<Int>
    }

    let scott = Player(score: Variable(80))
    let lori = Player(score: Variable(90))

    var player = Variable(scott)

    player.asObservable()
        .flatMap({ $0.score.asObservable() })
        .subscribe(onNext: { print("flatMap:", $0) })
        .addDisposableTo(disposeBag)

    player.asObservable()
        .flatMapLatest({ $0.score.asObservable() })
        .subscribe(onNext: { print("flatMapLatest:", $0) })
        .addDisposableTo(disposeBag)

    player.value.score.value = 85
    scott.score.value = 88

    player.value = lori
    scott.score.value = 95

    lori.score.value = 100
    player.value.score.value = 105
}

exampleOf("scan") {
    let disposeBag = DisposeBag()
    let dartScore = PublishSubject<Int>()

    dartScore.asObservable()
        .buffer(timeSpan: 0, count: 3, scheduler: MainScheduler.instance)
        .map({ $0.reduce(0, +) })
        .scan(501, accumulator: { intermediate, newValue in
            let result = intermediate - newValue

            return result == 0 || result > 1 ? result : intermediate
        })
        .do(onNext: {
            if $0 == 0 {
                dartScore.onCompleted()
            }
        })
        .subscribe({ $0.isStopEvent ? print($0) : print($0.element!) })
        .addDisposableTo(disposeBag)

    dartScore.onNext(13)
    dartScore.onNext(60)
    dartScore.onNext(50)
    dartScore.onNext(0)
    dartScore.onNext(0)
    dartScore.onNext(378)
}

//: [Next](@next)
