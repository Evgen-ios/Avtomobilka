//
//  Combine + Ext.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import Combine
import UIKit

typealias CancelBag = Set<AnyCancellable>

extension CancelBag {
    mutating func collect(@Builder _ cancellables: () -> [AnyCancellable]) {
        formUnion(cancellables())
    }

    @resultBuilder
    struct Builder {
        static func buildBlock(_ cancellables: AnyCancellable...) -> [AnyCancellable] {
            return cancellables
        }
    }
    
    func cancel() {
        self.forEach {$0.cancel()}
    }
}

struct AnyObserver<Output, Failure: Error> {
    let onNext: ((Output) -> Void)
    let onError: ((Failure) -> Void)
    let onComplete: (() -> Void)
}

struct Disposable {
    let dispose: () -> Void
}

extension AnyPublisher {
    static func create(subscribe: @escaping (AnyObserver<Output, Failure>) -> Disposable) -> Self {
        let subject = PassthroughSubject<Output, Failure>()
        var disposable: Disposable?
        return subject
            .handleEvents(receiveSubscription: { subscription in
                disposable = subscribe(AnyObserver(
                    onNext: { output in subject.send(output) },
                    onError: { failure in subject.send(completion: .failure(failure)) },
                    onComplete: { subject.send(completion: .finished) }
                ))
            }, receiveCancel: { disposable?.dispose() })
            .eraseToAnyPublisher()
    }
    func apiAnyPublisher() -> AnyPublisher {
        self.subscribe(on: DispatchQueue.global())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
    }
    
    func mapVoid() -> AnyPublisher<Void, Failure> {
        self.map({ _ in () }).eraseToAnyPublisher()
    }
}
