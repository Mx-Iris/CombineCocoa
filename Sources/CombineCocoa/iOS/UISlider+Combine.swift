//
//  UISlider+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)
import Combine
import UIKit

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UISlider {
    /// A publisher emitting value changes for this slider.
    var value: AnyPublisher<Float, Never> {
        Publishers.ControlProperty(control: base, events: .defaultValueEvents, keyPath: \.value)
            .eraseToAnyPublisher()
    }
}
#endif
