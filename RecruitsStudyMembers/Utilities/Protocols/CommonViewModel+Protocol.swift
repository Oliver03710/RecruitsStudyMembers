//
//  CommonViewModel+Protocol.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/09.
//

import Foundation

protocol CommonViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}
