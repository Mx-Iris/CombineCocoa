//
//  DelegateProxyPublisher.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Foundation
import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public class DelegateProxyPublisher<Output>: Publisher {
    public typealias Failure = Never

    private let handler: (AnySubscriber<Output, Failure>) -> Void

    public init(_ handler: @escaping (AnySubscriber<Output, Failure>) -> Void) {
        self.handler = handler
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Subscription(subscriber: AnySubscriber(subscriber), handler: handler)
        subscriber.receive(subscription: subscription)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
private extension DelegateProxyPublisher {
    class Subscription<S>: Combine.Subscription where S: Subscriber, Failure == S.Failure, Output == S.Input {
        private var subscriber: S?

        init(subscriber: S, handler: @escaping (S) -> Void) {
            self.subscriber = subscriber
            handler(subscriber)
        }

        func request(_ demand: Subscribers.Demand) {
            // We don't care for the demand.
        }

        func cancel() {
            subscriber = nil
        }
    }
}

