//
//  UIScrollView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 09/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Combine

extension UIScrollView: HasPublishers {}
extension UIScrollView: HasBinders {}

// swiftlint:disable force_cast
@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UIScrollView {
    /// A publisher emitting content offset changes from this UIScrollView.
    var contentOffset: AnyPublisher<CGPoint, Never> {
        base.publisher(for: \.contentOffset)
            .eraseToAnyPublisher()
    }

    /// A publisher emitting if the bottom of the UIScrollView is reached.
    ///
    /// - parameter offset: A threshold indicating how close to the bottom of the UIScrollView this publisher should emit.
    ///                     Defaults to 0
    /// - returns: A publisher that emits when the bottom of the UIScrollView is reached within the provided threshold.
    func reachedBottom(offset: CGFloat = 0) -> AnyPublisher<Void, Never> {
        contentOffset
            .map { [weak self] contentOffset -> Bool in
                guard let self = self?.base else { return false }
                let visibleHeight = self.frame.height - self.contentInset.top - self.contentInset.bottom
                let yDelta = contentOffset.y + self.contentInset.top
                let threshold = max(offset, self.contentSize.height - visibleHeight)
                return yDelta > threshold
            }
            .removeDuplicates()
            .filter { $0 }
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewDidScroll(_:)`
    var didScroll: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidScroll(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewWillBeginDecelerating(_:)`
    var willBeginDecelerating: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillBeginDecelerating(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewDidEndDecelerating(_:)`
    var didEndDecelerating: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidEndDecelerating(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewWillBeginDragging(_:)`
    var willBeginDragging: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillBeginDragging(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewWillEndDragging(_:withVelocity:targetContentOffset:)`
    var willEndDragging: AnyPublisher<(velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>), Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillEndDragging(_:withVelocity:targetContentOffset:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { values in
                let targetContentOffsetValue = values[2] as! NSValue
                let rawPointer = targetContentOffsetValue.pointerValue!

                return (values[1] as! CGPoint, rawPointer.bindMemory(to: CGPoint.self, capacity: MemoryLayout<CGPoint>.size))
            }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewDidEndDragging(_:willDecelerate:)`
    var didEndDragging: AnyPublisher<Bool, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidEndDragging(_:willDecelerate:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! Bool }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewDidZoom(_:)`
    var didZoom: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidZoom(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewDidScrollToTop(_:)`
    var didScrollToTop: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidScrollToTop(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewDidEndScrollingAnimation(_:)`
    var didEndScrollingAnimation: AnyPublisher<Void, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidEndScrollingAnimation(_:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { _ in () }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewWillBeginZooming(_:with:)`
    var willBeginZooming: AnyPublisher<UIView?, Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewWillBeginZooming(_:with:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! UIView? }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `scrollViewDidEndZooming(_:with:atScale:)`
    var didEndZooming: AnyPublisher<(view: UIView?, scale: CGFloat), Never> {
        let selector = #selector(UIScrollViewDelegate.scrollViewDidEndZooming(_:with:atScale:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView?, $0[2] as! CGFloat) }
            .eraseToAnyPublisher()
    }

    private var delegateProxy: DelegateProxy<UIScrollView, UIScrollViewDelegate> {
        ScrollViewDelegateProxy.createDelegateProxy(for: base)
    }
}

extension UIScrollView: HasDelegate {
    public typealias Delegate = UIScrollViewDelegate
}

@available(iOS 13.0, *)
private class ScrollViewDelegateProxy: DelegateProxy<UIScrollView, UIScrollViewDelegate>, UIScrollViewDelegate, DelegateProxyType {
    public typealias Object = UIScrollView
    public typealias Delegate = UIScrollViewDelegate

    public required init(object: Object) {
        self.object = object
        super.init(object: object)
    }

    public private(set) weak var object: Object?
}
#endif
// swiftlint:enable force_cast
