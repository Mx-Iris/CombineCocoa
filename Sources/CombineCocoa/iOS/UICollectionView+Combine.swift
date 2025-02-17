//
//  UICollectionView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 05/04/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import Combine

// swiftlint:disable force_cast
@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UICollectionView {
    /// Combine wrapper for `collectionView(_:didSelectItemAt:)`
    var didSelectItem: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didSelectItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didDeselectItemAt:)`
    var didDeselectItem: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didDeselectItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didHighlightItemAt:)`
    var didHighlightItem: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didHighlightItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didUnhighlightItemAt:)`
    var didUnhighlightRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didUnhighlightItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:willDisplay:forItemAt:)`
    var willDisplayCell: AnyPublisher<(cell: UICollectionViewCell, indexPath: IndexPath), Never> {
        let selector = #selector(UICollectionViewDelegate.collectionView(_:willDisplay:forItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UICollectionViewCell, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:willDisplaySupplementaryView:forElementKind:at:)`
    var willDisplaySupplementaryView: AnyPublisher<(supplementaryView: UICollectionReusableView, elementKind: String, indexPath: IndexPath), Never> {
        let selector = #selector(UICollectionViewDelegate.collectionView(_:willDisplaySupplementaryView:forElementKind:at:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UICollectionReusableView, $0[2] as! String, $0[3] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didEndDisplaying:forItemAt:)`
    var didEndDisplayingCell: AnyPublisher<(cell: UICollectionViewCell, indexPath: IndexPath), Never> {
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didEndDisplaying:forItemAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UICollectionViewCell, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `collectionView(_:didEndDisplayingSupplementaryView:forElementKind:at:)`
    var didEndDisplaySupplementaryView: AnyPublisher<(supplementaryView: UICollectionReusableView, elementKind: String, indexPath: IndexPath), Never> {
        let selector = #selector(UICollectionViewDelegate.collectionView(_:didEndDisplayingSupplementaryView:forElementOfKind:at:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UICollectionReusableView, $0[2] as! String, $0[3] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    private var delegateProxy: CollectionViewDelegateProxy {
        .createDelegateProxy(for: base)
    }
}

@available(iOS 13.0, *)
private class CollectionViewDelegateProxy: DelegateProxy<UICollectionView, UICollectionViewDelegate>, UICollectionViewDelegate, DelegateProxyType {
    func currentDelegate() -> Delegate? {
        object?.delegate
    }

    func setCurrentDelegate(_ delegate: Delegate?) {
        object?.delegate = delegate
    }

    typealias Object = UICollectionView
    typealias Delegate = UICollectionViewDelegate

    weak var object: UICollectionView?

    required init(object: UICollectionView) {
        self.object = object
        super.init(object: object)
    }
}

#endif
// swiftlint:enable force_cast
