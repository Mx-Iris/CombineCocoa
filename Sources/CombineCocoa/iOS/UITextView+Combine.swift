//
//  UITextView+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 10/08/2020.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import Combine

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UITextView {
    /// A Combine publisher for the `UITextView's` value.
    ///
    /// - note: This uses the underlying `NSTextStorage` to make sure
    ///         autocorrect changes are reflected as well.
    ///
    /// - seealso: https://git.io/JJM5Q
    var value: AnyPublisher<String?, Never> {
        Deferred { [weak textView = base] in
            textView?.textStorage.publishers
                .didProcessEditingRangeChangeInLengthPublisher
                .map { _ in textView?.text }
                .prepend(textView?.text)
                .eraseToAnyPublisher() ?? Empty().eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }

    var text: AnyPublisher<String?, Never> { value }
}
#endif
