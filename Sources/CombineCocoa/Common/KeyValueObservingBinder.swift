//
//  KeyValueObservingBinder.swift
//  CombineCocoa
//
//  Created by JH on 2022/10/30.
//

import Foundation
import Combine

public protocol KeyValueCodingAndObservingBinding {}

extension NSObject: KeyValueCodingAndObservingBinding {}

public extension KeyValueCodingAndObservingBinding where Self: NSObject {
    func binder<Value>(for keyPath: ReferenceWritableKeyPath<Self, Value>) -> NSObject.KeyValueObservingBinder<Self, Value> {
        .init(target: self, keyPath: keyPath)
    }
}

public extension NSObject {
    struct KeyValueObservingBinder<Target: NSObject, Value> {
        public let target: Target
        public let keyPath: ReferenceWritableKeyPath<Target, Value>

        public init(target: Target, keyPath: ReferenceWritableKeyPath<Target, Value>) {
            self.target = target
            self.keyPath = keyPath
        }
    }
}

extension NSObject.KeyValueObservingBinder: Subscriber {
    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    public func receive(completion: Subscribers.Completion<Never>) {}

    public var combineIdentifier: CombineIdentifier { .init(target) }

    public typealias Input = Value
    public typealias Failure = Never

    public func receive(_ input: Value) -> Subscribers.Demand {
        target[keyPath: keyPath] = input
        return .none
    }
}
