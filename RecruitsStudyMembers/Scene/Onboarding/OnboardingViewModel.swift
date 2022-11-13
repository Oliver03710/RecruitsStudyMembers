//
//  OnboardingViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/13.
//

import Foundation

import RxCocoa
import RxSwift

final class OnboardingViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let tapDriver: SharedSequence<DriverSharingStrategy, Void>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let tapDriver = input.tap.asDriver()
        
        return Output(tapDriver: tapDriver)
    }
}
