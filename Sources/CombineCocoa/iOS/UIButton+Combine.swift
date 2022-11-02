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
public extension CombineCocoaPublishers where Base: UIButton {
    /// A publisher emitting tap events from this button.
    var tap: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .touchUpInside)
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaBinders where Base: UIButton {
    func title(for controlState: UIControl.State) -> Binder<String?> {
        Binder(base) { button, title in
            button.setTitle(title, for: controlState)
        }
    }
    
    func titleColor(for controlState: UIControl.State) -> Binder<UIColor?> {
        Binder(base) { button, titleColor in
            button.setTitleColor(titleColor, for: controlState)
        }
    }
    
    func image(for controlState: UIControl.State) -> Binder<UIImage?> {
        Binder(base) { button, image in
            button.setImage(image, for: controlState)
        }
    }
    
    func backgroundImage(for controlState: UIControl.State) -> Binder<UIImage?> {
        Binder(base) { button, backgroundImage in
            button.setBackgroundImage(backgroundImage, for: controlState)
        }
    }
    
    func attributedTitle(for controlState: UIControl.State) -> Binder<NSAttributedString?> {
        Binder(base) { button, attributedTitle in
            button.setAttributedTitle(attributedTitle, for: controlState)
        }
    }
}

#endif
