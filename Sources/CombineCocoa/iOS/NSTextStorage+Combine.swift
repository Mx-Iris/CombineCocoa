//
//  NSTextStorage+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 10/08/2020.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(AppKit)
import AppKit
#elseif canImport(UIKit)
import UIKit
#endif

import Combine

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension NSTextStorage: HasPublishers {}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
public extension CombineCocoa where Base: NSTextStorage {
    /// Combine publisher for `NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:)`
    var didProcessEditingRangeChangeInLengthPublisher: AnyPublisher<(editedMask: NSTextStorage.EditActions, editedRange: NSRange, delta: Int), Never> {
        let selector = #selector(NSTextStorageDelegate.textStorage(_:didProcessEditing:range:changeInLength:))

        return delegateProxy
            .interceptSelectorPublisher(selector)
            .map { args -> (editedMask: NSTextStorage.EditActions, editedRange: NSRange, delta: Int) in
                // swiftlint:disable force_cast
                let editedMask = NSTextStorage.EditActions(rawValue: args[1] as! UInt)
                let editedRange = (args[2] as! NSValue).rangeValue
                let delta = args[3] as! Int
                return (editedMask, editedRange, delta)
                // swiftlint:enable force_cast
            }
            .eraseToAnyPublisher()
    }

    private var delegateProxy: NSTextStorageDelegateProxy {
        .createDelegateProxy(for: base)
    }
}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
extension NSTextStorage: HasDelegate {}

@available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
private class NSTextStorageDelegateProxy: DelegateProxy<NSTextStorage, NSTextStorageDelegate>, NSTextStorageDelegate, DelegateProxyType {
    typealias Object = NSTextStorage

    typealias Delegate = NSTextStorageDelegate

    weak var object: Object?

    required init(object: Object) {
        self.object = object
        super.init(object: object)
    }
}
