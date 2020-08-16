//
//  InstantiableFromStoryboard.swift
//  othelloSwift
//
//  Created by Kazuki on 2020/08/16.
//  Copyright © 2020 susu. All rights reserved.
//

import Foundation
import UIKit

public protocol InstantiableFromStoryboard: BundleSearchable {

    associatedtype VCType = Self

    static var storyboardName: String { get }
    static var defaultIdentifier: String? { get }

    static func instantiate() -> VCType
}

extension InstantiableFromStoryboard {

    public static var storyboardName: String {
        return String(describing: VCType.self)
    }

    public static var defaultIdentifier: String? {
        return nil
    }

    public static func instantiate() -> VCType {
        let storyboard = UIStoryboard(name: storyboardName, bundle: searchBundle())

        if let identifier = defaultIdentifier {
            return storyboard.instantiateViewController(withIdentifier: identifier) as! VCType
        } else {
            return storyboard.instantiateInitialViewController() as! VCType
        }
    }
}

public protocol BundleSearchable {

    static func searchBundle() -> Bundle?
}

extension BundleSearchable {

    public static func searchBundle() -> Bundle? {
        if let anyClass = self as? AnyClass {
            return Bundle(for: anyClass)
        } else {
            return nil
        }
    }
}
