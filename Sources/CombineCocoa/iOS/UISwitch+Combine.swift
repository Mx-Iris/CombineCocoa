//
//  UISwitch+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UISwitch {
    /// A publisher emitting on status changes for this switch.
    var isOn: AnyPublisher<Bool, Never> {
        Publishers.ControlProperty(control: base, events: .defaultValueEvents, keyPath: \.isOn)
            .eraseToAnyPublisher()
    }
}
#endif
