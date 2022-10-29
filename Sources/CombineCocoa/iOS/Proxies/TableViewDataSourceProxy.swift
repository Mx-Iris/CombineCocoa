//
//  File.swift
//  
//
//  Created by JH on 2022/10/30.
//

#if os(iOS)

import UIKit
import Combine

extension UITableView: HasDataSource {
    public typealias DataSource = UITableViewDataSource
}

private let tableViewDataSourceNotSet = TableViewDataSourceNotSet()

private class TableViewDataSourceNotSet: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        .init()
    }
}

@available(iOS 13.0, *)
open class TableViewDataSourceProxy: DelegateProxy<UITableView, UITableViewDataSource>, DelegateProxyType, UITableViewDataSource {
    public weak var object: UITableView?

    private weak var requiredMethodsDataSource: UITableViewDataSource?

    public required init(object: UITableView) {
        self.object = object
        super.init(object: object)
    }

    open override func setForwardToDelegate(_ delegate: UITableViewDataSource?) {
        requiredMethodsDataSource = delegate
        super.setForwardToDelegate(delegate)
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (requiredMethodsDataSource ?? tableViewDataSourceNotSet).tableView(tableView, numberOfRowsInSection: section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        (requiredMethodsDataSource ?? tableViewDataSourceNotSet).tableView(tableView, cellForRowAt: indexPath)
    }
}

#endif
