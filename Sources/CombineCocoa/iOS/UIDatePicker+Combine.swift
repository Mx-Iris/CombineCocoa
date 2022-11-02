//
//  UIDatePicker+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)
import Combine
import UIKit

extension UIDatePicker: HasPublishers {}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UIDatePicker {
    /// A publisher emitting date changes from this date picker.
    var date: AnyPublisher<Date, Never> {
        Publishers.ControlProperty(control: base, events: .defaultValueEvents, keyPath: \.date)
            .eraseToAnyPublisher()
    }

    /// A publisher emitting countdown duration changes from this date picker.
    var countDownDuration: AnyPublisher<TimeInterval, Never> {
        Publishers.ControlProperty(control: base, events: .defaultValueEvents, keyPath: \.countDownDuration)
            .eraseToAnyPublisher()
    }
}
#endif
