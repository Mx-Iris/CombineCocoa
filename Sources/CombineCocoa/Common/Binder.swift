//
//  Binder.swift
//  CombineCocoa
//
//  Created by JH on 2022/10/30.
//

import Foundation
import Combine

public struct Binder<Input>: Subscriber {
    
    public typealias Failure = Never
    
    private let binding: (Input) -> Void
    
    public var combineIdentifier: CombineIdentifier = .init()

    public init<Target: AnyObject>(_ target: Target, binding: @escaping (Target, Input) -> Void) {
        weak var weakTarget = target
        self.binding = { input in
            if let target = weakTarget {
                binding(target, input)
            }
        }
    }
    
    public func receive(_ input: Input) -> Subscribers.Demand {
        binding(input)
        return .none
    }
    
    public func receive(completion: Subscribers.Completion<Never>) {}
    
    public func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }
}
