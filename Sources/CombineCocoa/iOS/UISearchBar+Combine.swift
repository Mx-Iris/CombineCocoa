//
//  UISearchBar+Combine.swift
//  CombineCocoa
//
//  Created by Kevin Renskers on 01/10/2020.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import UIKit
import Combine

// swiftlint:disable force_cast
@available(iOS 13.0, *)
public extension CombineCocoa where Base: UISearchBar {
    /// Combine wrapper for `UISearchBarDelegate.searchBar(_:textDidChange:)`
    var textDidChange: AnyPublisher<String, Never> {
        let selector = #selector(UISearchBarDelegate.searchBar(_:textDidChange:))
        return delegateProxy
            .interceptSelectorPublisher(selector)
            .map { $0[1] as! String }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `UISearchBarDelegate.searchBarSearchButtonClicked(_:)`
    var searchButtonClicked: AnyPublisher<Void, Never> {
        let selector = #selector(UISearchBarDelegate.searchBarSearchButtonClicked(_:))
        return delegateProxy
            .interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `UISearchBarDelegate.searchBarCancelButtonClicked(_:)`
    var cancelButtonClicked: AnyPublisher<Void, Never> {
        let selector = #selector(UISearchBarDelegate.searchBarCancelButtonClicked(_:))
        return delegateProxy
            .interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    private var delegateProxy: UISearchBarDelegateProxy {
        .createDelegateProxy(for: base)
    }
}

@available(iOS 13.0, *)
extension UISearchBar: HasDelegate {}

@available(iOS 13.0, *)
private class UISearchBarDelegateProxy: DelegateProxy<UISearchBar, UISearchBarDelegate>, UISearchBarDelegate, DelegateProxyType {
    typealias Object = UISearchBar
    typealias Delegate = UISearchBarDelegate
    weak var object: UISearchBar?
    required init(object: UISearchBar) {
        self.object = object
        super.init(object: object)
    }
}
#endif
// swiftlint:enable force_cast
