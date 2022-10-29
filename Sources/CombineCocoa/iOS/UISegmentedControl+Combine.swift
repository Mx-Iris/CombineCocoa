//
//  UISegmentedControl+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
public extension CombineCocoa where Base: UISegmentedControl {
    /// A publisher emitting selected segment index changes for this segmented control.
    var selectedSegmentIndex: AnyPublisher<Int, Never> {
        Publishers.ControlProperty(control: base, events: .defaultValueEvents, keyPath: \.selectedSegmentIndex)
            .eraseToAnyPublisher()
    }
}
#endif
