//
//  CombineCocoaBinders.swift
//  CombineCocoa
//
//  Created by JH on 2022/10/30.
//

import Foundation

public class CombineCocoaBinders<Base> {
    public let base: Base
    public init(base: Base) {
        self.base = base
    }
}

public protocol HasBinders {
    associatedtype Base
    static var binders: CombineCocoaBinders<Base>.Type { get set }
    var binders: CombineCocoaBinders<Base> { get set }
}

public extension HasBinders {
    static var binders: CombineCocoaBinders<Self>.Type {
        get { CombineCocoaBinders<Self>.self }
        set {}
    }

    var binders: CombineCocoaBinders<Self> {
        get { .init(base: self) }
        set {}
    }
}
