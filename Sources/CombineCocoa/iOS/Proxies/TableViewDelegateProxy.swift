//
//  File.swift
//
//
//  Created by JH on 2022/10/30.
//

#if canImport(UIKit)

import UIKit

@available(iOS 13.0, *)
open class TableViewDelegateProxy: DelegateProxy<UITableView, UITableViewDelegate>, UITableViewDelegate, DelegateProxyType {
    open func currentDelegate() -> Delegate? {
        object?.delegate
    }

    open func setCurrentDelegate(_ delegate: Delegate?) {
        object?.delegate = delegate
    }

    public typealias Object = UITableView

    public typealias Delegate = UITableViewDelegate

    public private(set) weak var object: UITableView?

    public required init(object: UITableView) {
        self.object = object
        super.init(object: object)
    }
}

#endif
