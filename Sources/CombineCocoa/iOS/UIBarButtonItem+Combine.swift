//
//  UIBarButtonItem+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 12/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)

import Combine
import UIKit

@available(iOS 13.0, *)
extension UIBarButtonItem: HasPublishers {}

@available(iOS 13.0, *)
public extension CombineCocoa where Base: UIBarButtonItem {
    /// A publisher which emits whenever this UIBarButtonItem is tapped.
    var tap: AnyPublisher<Void, Never> {
        Publishers.ControlTarget(
            control: base,
            addTargetAction: { control, target, action in
                control.target = target
                control.action = action
            },
            removeTargetAction: { control, _, _ in
                control?.target = nil
                control?.action = nil
            }
        )
        .eraseToAnyPublisher()
    }
}
#endif
