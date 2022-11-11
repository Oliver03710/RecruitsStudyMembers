//
//  GenderViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

import RxCocoa
import RxSwift

final class GenderViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let tap: ControlEvent<Void>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        
        return Output(tap: input.tap)
    }
}
