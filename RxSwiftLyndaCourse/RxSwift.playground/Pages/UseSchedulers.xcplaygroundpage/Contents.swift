//: [Previous](@previous)

import PlaygroundSupport
import RxSwift

PlaygroundPage.current.needsIndefiniteExecution = true

let frame = CGRect(x: 0, y: 0, width: 512, height: 512)
let imageView = UIImageView(frame: frame)

PlaygroundPage.current.liveView = imageView

let rx = UIImage(named: "Rx")!
let rxData = UIImagePNGRepresentation(rx)!

let swift = UIImage(named: "Swift")!
let swiftData = UIImagePNGRepresentation(swift)!

let disposeBag = DisposeBag()

let imageDataSubject = PublishSubject<Data>()

let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)

let concurrentQueue = DispatchQueue(label: "io.swift-yag.concurrentQueue", attributes: .concurrent)
let serialScheduler = SerialDispatchQueueScheduler(queue: concurrentQueue, internalSerialQueueName: "io.swift-yah.serialQueue")

let operationQueue = OperationQueue()
operationQueue.qualityOfService = .background

let nsScheduler = OperationQueueScheduler(operationQueue: operationQueue)

imageDataSubject
    .observeOn(nsScheduler)
    .map({ UIImage(data: $0) })
    .observeOn(MainScheduler.instance)
    .subscribe(onNext: { imageView.image = $0 })
    .addDisposableTo(disposeBag)

imageDataSubject.onNext(rxData)
imageDataSubject.onNext(swiftData)

//: [Next](@next)
