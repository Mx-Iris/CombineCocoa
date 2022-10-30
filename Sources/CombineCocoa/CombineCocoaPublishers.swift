//
//  CombineCocoa.swift
//  CombineCocoa
//
//  Created by JH on 2022/10/29.
//

import Foundation

public class CombineCocoaPublishers<Base> {
    public let base: Base
    public init(base: Base) {
        self.base = base
    }
}

public protocol HasPublishers {
    associatedtype Base
    static var publishers: CombineCocoaPublishers<Base>.Type { get set }
    var publishers: CombineCocoaPublishers<Base> { get set }
}

public extension HasPublishers {
    static var publishers: CombineCocoaPublishers<Self>.Type {
        get { CombineCocoaPublishers<Self>.self }
        set {}
    }

    var publishers: CombineCocoaPublishers<Self> {
        get { .init(base: self) }
        set {}
    }
}
