//
//  DelegateProxyType.swift
//  CombineCocoa
//
//  Created by Joan Disho on 25/09/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

import Foundation
import ObjectiveC.runtime

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol DelegateProxyType: AnyObject {
    associatedtype Object: AnyObject
    associatedtype Delegate: AnyObject
    var object: Object? { get }
    static var identifier: UnsafeRawPointer { get }
    init(object: Object)
    func currentDelegate() -> Delegate?
    func setCurrentDelegate(_ delegate: Delegate?)
    func forwardToDelegate() -> Delegate?
    func setForwardToDelegate(_ delegate: Delegate?)
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension DelegateProxyType {
    static func createDelegateProxy(for object: Object) -> Self {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        let delegateProxy: Self

        if let associatedObject = objc_getAssociatedObject(object, identifier) as? Self {
            delegateProxy = associatedObject
        } else {
            delegateProxy = .init(object: object)
            objc_setAssociatedObject(object, identifier, delegateProxy, .OBJC_ASSOCIATION_RETAIN)
        }

        let currentDelegate = delegateProxy.currentDelegate()

        if currentDelegate !== delegateProxy {
            delegateProxy.setForwardToDelegate(currentDelegate)
            
            delegateProxy.setCurrentDelegate(delegateProxy as? Delegate)
            
        }

        return delegateProxy
    }
}
@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension DelegateProxyType {
    static var identifier: UnsafeRawPointer {
        let delegateIdentifier = ObjectIdentifier(Delegate.self)
        let integerIdentifier = Int(bitPattern: delegateIdentifier)
        return UnsafeRawPointer(bitPattern: integerIdentifier)!
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol HasDataSource: AnyObject {
    associatedtype DataSource
    var dataSource: DataSource? { set get }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public protocol HasDelegate: AnyObject {
    associatedtype Delegate
    var delegate: Delegate? { set get }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension DelegateProxyType where Object: HasDataSource, Self.Delegate == Object.DataSource {
    func currentDelegate() -> Delegate? {
        object?.dataSource
    }
    func setCurrentDelegate(_ delegate: Delegate?) {
        object?.dataSource = delegate
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension DelegateProxyType where Object: HasDelegate, Self.Delegate == Object.Delegate {
    func currentDelegate() -> Delegate? {
        object?.delegate
    }
    func setCurrentDelegate(_ delegate: Delegate?) {
        object?.delegate = delegate
    }
}


