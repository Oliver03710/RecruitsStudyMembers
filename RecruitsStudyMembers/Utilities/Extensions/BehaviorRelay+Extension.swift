//
//  BehaviorRelay+Extension.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/27.
//

import RxCocoa

extension BehaviorRelay where Element: RangeReplaceableCollection {
    func acceptAppending(_ element: Element.Element) {
        accept(value + [element])
    }
}
