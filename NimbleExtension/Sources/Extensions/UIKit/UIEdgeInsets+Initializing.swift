//
//  UIEdgeInsets+Initializing.swift
//  Extensions
//
//  Created by Pirush Prechathavanich on 5/6/19.
//

import UIKit

public extension UIEdgeInsets {

    // MARK: - by axis

    var vertical: CGFloat { return top + bottom }

    var horizontal: CGFloat { return left + right }

    /// Returns insets which top and bottom insets are set as input
    static func vertical(each value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets.zero.vertical(each: value)
    }

    /// Returns insets which left and right insets are set as input
    static func horizontal(each value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets.zero.horizontal(each: value)
    }

    // MARK: - by side

    static func top(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets.zero.top(value)
    }

    static func bottom(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets.zero.bottom(value)
    }

    static func left(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets.zero.left(value)
    }

    static func right(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets.zero.right(value)
    }

    static func all(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: value, bottom: value, right: value)
    }

    static func edges(top: CGFloat = 0.0, left: CGFloat = 0.0, bottom: CGFloat = 0.0, right: CGFloat = 0.0) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    static func each(vertical: CGFloat, horizontal: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(
            top: vertical,
            left: horizontal,
            bottom: vertical,
            right: horizontal
        )
    }
}

// MARK: - builder

public extension UIEdgeInsets {

    // MARK: - by axis

    func horizontal(each value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: value, bottom: bottom, right: value)
    }

    func vertical(each value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: left, bottom: value, right: right)
    }

    // MARK: - by side

    func top(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: value, left: left, bottom: bottom, right: right)
    }

    func bottom(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: value, right: right)
    }

    func left(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: value, bottom: bottom, right: right)
    }

    func right(_ value: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: value)
    }

}
