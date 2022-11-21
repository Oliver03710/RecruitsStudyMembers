//
//  Reusable+Protocol.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/15.
//

import UIKit

private protocol ReusableViewProtocol {
    static var reuseIdentifier: String { get }
}

extension UIViewController: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: ReusableViewProtocol {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
