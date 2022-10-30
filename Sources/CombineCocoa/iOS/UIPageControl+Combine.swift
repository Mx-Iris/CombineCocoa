//
//  UIPageControl+Combine.swift
//  CombineCocoa
//
//  Created by Shai Mishali on 02/08/2019.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if !(os(iOS) && (arch(i386) || arch(arm)))
import Combine
import UIKit

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UIPageControl {
    /// A publisher emitting current page changes for this page control.
    var currentPage: AnyPublisher<Int, Never> {
        base.publisher(for: \.currentPage).eraseToAnyPublisher()
    }
}
#endif
