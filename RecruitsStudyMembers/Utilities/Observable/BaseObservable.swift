//
//  BaseObservable.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/18.
//

import Foundation

final class BaseObservable<T> {
    
    // MARK: - Properties
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    
    // MARK: - Init
    
    init(_ value: T) {
        self.value = value
    }
    
    
    // MARK: - Helper Functions
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
    
}
