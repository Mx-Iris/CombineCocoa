//
//  UIControl+Combine.swift
//  CombineCocoa
//
//  Created by Wes Wickwire on 9/23/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)
import Combine
import UIKit

extension UIControl: HasPublishers {}
extension UIControl: HasBinders {}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UIControl {
    /// A publisher emitting events from this control.
    func controlEventPublisher(for events: UIControl.Event) -> AnyPublisher<Void, Never> {
        Publishers.ControlEvent(control: base, events: events)
            .eraseToAnyPublisher()
    }
}
#endif
