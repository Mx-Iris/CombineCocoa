//
//  Publisher+Bind.swift
//  CombineCocoa
//
//  Created by JH on 2022/10/30.
//

import Foundation
import Combine

public extension Publisher where Failure == Never {
    func bind<S: Subscriber>(to subscriber: S) -> AnyCancellable
        where S.Failure == Never, S.Input == Output {
        handleEvents { subscription in
            subscriber.receive(subscription: subscription)
        }
        .sink { value in
            _ = subscriber.receive(value)
        }
    }
}
