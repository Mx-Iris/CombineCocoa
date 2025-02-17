//
//  UITableView+Combine.swift
//  CombineCocoa
//
//  Created by Joan Disho on 19/01/20.
//  Copyright © 2020 Combine Community. All rights reserved.
//

#if canImport(UIKit)

import UIKit
import Combine

// swiftlint:disable force_cast
@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UITableView {
    var delegateProxy: TableViewDelegateProxy {
        .createDelegateProxy(for: base)
    }

    /// Combine wrapper for `tableView(_:willDisplay:forRowAt:)`
    var willDisplayCell: AnyPublisher<(cell: UITableViewCell, indexPath: IndexPath), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:willDisplay:forRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UITableViewCell, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:willDisplayHeaderView:forSection:)`
    var willDisplayHeaderView: AnyPublisher<(headerView: UIView, section: Int), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:willDisplayHeaderView:forSection:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView, $0[2] as! Int) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:willDisplayFooterView:forSection:)`
    var willDisplayFooterView: AnyPublisher<(footerView: UIView, section: Int), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:willDisplayFooterView:forSection:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView, $0[2] as! Int) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplaying:forRowAt:)`
    var didEndDisplayingCell: AnyPublisher<(cell: UITableViewCell, indexPath: IndexPath), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplaying:forRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UITableViewCell, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplayingHeaderView:forSection:)`
    var didEndDisplayingHeaderView: AnyPublisher<(headerView: UIView, section: Int), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplayingHeaderView:forSection:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView, $0[2] as! Int) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndDisplayingFooterView:forSection:)`
    var didEndDisplayingFooterView: AnyPublisher<(headerView: UIView, section: Int), Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didEndDisplayingFooterView:forSection:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! UIView, $0[2] as! Int) }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:accessoryButtonTappedForRowWith:)`
    var itemAccessoryButtonTapped: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:accessoryButtonTappedForRowWith:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didHighlightRowAt:)`
    var didHighlightRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didHighlightRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didUnHighlightRowAt:)`
    var didUnhighlightRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didUnhighlightRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didSelectRowAt:)`
    var didSelectRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didSelectRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didDeselectRowAt:)`
    var didDeselectRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didDeselectRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:willBeginEditingRowAt:)`
    var willBeginEditingRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:willBeginEditingRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }

    /// Combine wrapper for `tableView(_:didEndEditingRowAt:)`
    var didEndEditingRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDelegate.tableView(_:didEndEditingRowAt:))
        return delegateProxy.interceptSelectorPublisher(selector)
            .map { $0[1] as! IndexPath }
            .eraseToAnyPublisher()
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaPublishers where Base: UITableView {
    var dataSourceProxy: TableViewDataSourceProxy {
        .createDelegateProxy(for: base)
    }

    var didDeleteRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDataSource.tableView(_:commit:forRowAt:))
        return dataSourceProxy.interceptSelectorPublisher(selector)
            .filter { UITableViewCell.EditingStyle(rawValue: ($0[1] as! NSNumber).intValue) == .delete }
            .map { $0[2] as! IndexPath }
            .eraseToAnyPublisher()
    }

    var didMoveRow: AnyPublisher<(source: IndexPath, destination: IndexPath), Never> {
        let selector = #selector(UITableViewDataSource.tableView(_:moveRowAt:to:))
        return dataSourceProxy.interceptSelectorPublisher(selector)
            .map { ($0[1] as! IndexPath, $0[2] as! IndexPath) }
            .eraseToAnyPublisher()
    }

    var didInsertRow: AnyPublisher<IndexPath, Never> {
        let selector = #selector(UITableViewDataSource.tableView(_:commit:forRowAt:))
        return dataSourceProxy.interceptSelectorPublisher(selector)
            .filter { UITableViewCell.EditingStyle(rawValue: ($0[1] as! NSNumber).intValue) == .insert }
            .map { $0[2] as! IndexPath }
            .eraseToAnyPublisher()
    }
}

@available(iOS 13.0, *)
public extension CombineCocoaBinders where Base: UITableView {
    func items<Section, Item>(_ dataSource: UITableViewDiffableDataSource<Section, Item>, animatingDifferences: Bool) -> AnySubscriber<NSDiffableDataSourceSnapshot<Section, Item>, Never> {
        AnySubscriber<NSDiffableDataSourceSnapshot<Section, Item>, Never> { subscription in
            subscription.request(.unlimited)
        } receiveValue: { [weak view = base as UITableView] snapshot -> Subscribers.Demand in
            guard let view = view else { return .none }
            if let currentDataSource = view.dataSource as? UITableViewDiffableDataSource<Section, Item> {
                currentDataSource.apply(snapshot, animatingDifferences: animatingDifferences)
            } else {
                view.dataSource = dataSource
                dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
            }
            return .unlimited
        } receiveCompletion: { _ in }
    }
}

#endif
// swiftlint:enable force_cast
