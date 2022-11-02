//
//  UITextField+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import Combine

extension UITextField: HasPublishers {}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UITextField {
    /// A publisher emitting any text changes to a this text field.
    var text: AnyPublisher<String?, Never> {
        Publishers.ControlProperty(control: base, events: .defaultValueEvents, keyPath: \.text)
            .eraseToAnyPublisher()
    }

    /// A publisher emitting any attributed text changes to this text field.
    var attributedText: AnyPublisher<NSAttributedString?, Never> {
        Publishers.ControlProperty(control: base, events: .defaultValueEvents, keyPath: \.attributedText)
            .eraseToAnyPublisher()
    }

    /// A publisher that emits whenever the user taps the return button and ends the editing on the text field.
    var `return`: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .editingDidEndOnExit)
    }

    /// A publisher that emits whenever the user taps the text fields and begin the editing.
    var didBeginEditing: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .editingDidBegin)
    }
}
#endif
