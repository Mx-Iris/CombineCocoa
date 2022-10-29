//
//  CombineCocoa.swift
//  CombineCocoa
//
//  Created by JH on 2022/10/29.
//

import Foundation

public class CombineCocoa<Base> {
    public let base: Base
    public init(base: Base) {
        self.base = base
    }
}

public protocol HasPublishers {
    associatedtype Base
    static var publishers: CombineCocoa<Base>.Type { get set }
    var publishers: CombineCocoa<Base> { get set }
}

public extension HasPublishers {
    static var publishers: CombineCocoa<Self>.Type {
        get { CombineCocoa<Self>.self }
        set {}
    }

    var publishers: CombineCocoa<Self> {
        get { .init(base: self) }
        set {}
    }
}
