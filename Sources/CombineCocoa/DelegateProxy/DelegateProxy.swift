//
//  DelegateProxy.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Foundation
import Combine

#if canImport(Runtime)
import Runtime
#endif

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
open class DelegateProxy<Object: AnyObject, Delegate>: ObjcDelegateProxy {
    private var dict: [Selector: [([Any]) -> Void]] = [:]
    private var subscribers = [AnySubscriber<[Any], Never>?]()
    private weak var object: Object?
    public required init(object: Object) {
        self.object = object
        super.init()
    }
    
    public func forwardToDelegate() -> Delegate? {
        self._forwardToDelegate as? Delegate
    }
    
    public func setForwardToDelegate(_ delegate: Delegate?) {
        self._setForwardToDelegate(delegate)
    }
    
    public override func interceptedSelector(_ selector: Selector, arguments: [Any]) {
        dict[selector]?.forEach { handler in
            handler(arguments)
        }
    }

    public func intercept(_ selector: Selector, _ handler: @escaping ([Any]) -> Void) {
        if dict[selector] != nil {
            dict[selector]?.append(handler)
        } else {
            dict[selector] = [handler]
        }
    }

    public func interceptSelectorPublisher(_ selector: Selector) -> AnyPublisher<[Any], Never> {
        DelegateProxyPublisher<[Any]> { subscriber in
            self.subscribers.append(subscriber)
            return self.intercept(selector) { args in
                _ = subscriber.receive(args)
            }
        }.eraseToAnyPublisher()
    }

    deinit {
        subscribers.forEach { $0?.receive(completion: .finished) }
        subscribers = []
    }
}
#endif
