//
//  UIGestureRecognizer+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)
import Combine
import UIKit

extension UIGestureRecognizer: HasPublishers {}

// MARK: - Gesture Publishers

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UITapGestureRecognizer {
    /// A publisher which emits when this Tap Gesture Recognizer is triggered
    var tap: AnyPublisher<UITapGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UIPinchGestureRecognizer {
    /// A publisher which emits when this Pinch Gesture Recognizer is triggered
    var pinch: AnyPublisher<UIPinchGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UIRotationGestureRecognizer {
    /// A publisher which emits when this Rotation Gesture Recognizer is triggered
    var rotation: AnyPublisher<UIRotationGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UISwipeGestureRecognizer {
    /// A publisher which emits when this Swipe Gesture Recognizer is triggered
    var swipe: AnyPublisher<UISwipeGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UIPanGestureRecognizer {
    /// A publisher which emits when this Pan Gesture Recognizer is triggered
    var pan: AnyPublisher<UIPanGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UIScreenEdgePanGestureRecognizer {
    /// A publisher which emits when this Screen Edge Gesture Recognizer is triggered
    var screenEdgePan: AnyPublisher<UIScreenEdgePanGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UILongPressGestureRecognizer {
    /// A publisher which emits when this Long Press Recognizer is triggered
    var longPress: AnyPublisher<UILongPressGestureRecognizer, Never> {
        gesturePublisher(for: base)
    }
}

// MARK: - Private Helpers

// A private generic helper function which returns the provided
// generic publisher whenever its specific event occurs.
@available(iOS 13.0, *)
private func gesturePublisher<Gesture: UIGestureRecognizer>(for gesture: Gesture) -> AnyPublisher<Gesture, Never> {
    Publishers.ControlTarget(
        control: gesture,
        addTargetAction: { gesture, target, action in
            gesture.addTarget(target, action: action)
        },
        removeTargetAction: { gesture, target, action in
            gesture?.removeTarget(target, action: action)
        }
    )
    .subscribe(on: DispatchQueue.main)
    .map { gesture }
    .eraseToAnyPublisher()
}
#endif
