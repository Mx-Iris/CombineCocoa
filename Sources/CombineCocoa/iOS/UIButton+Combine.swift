//
//  UIButton+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)

import Combine
import UIKit

@available(iOS 13.0, *)
public extension CombineCocoa where Base: UIButton {
    /// A publisher emitting tap events from this button.
    var tap: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .touchUpInside)
    }
}

#endif
