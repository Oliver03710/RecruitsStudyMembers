//
//  LoginViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/09.
//

import Foundation

import RxCocoa
import RxSwift

final class LoginViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    let photo = PublishSubject<Data>()
    let userName = PublishRelay<String>()
    let email = PublishRelay<String>()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let tap: ControlEvent<Void>
        let name: SharedSequence<DriverSharingStrategy, String>
        let email: SharedSequence<DriverSharingStrategy, String>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let nameTransformed = userName.asDriver(onErrorJustReturn: "")
        let emailTransformed = email.asDriver(onErrorJustReturn: "")
        
        return Output(tap: input.tap, name: nameTransformed, email: emailTransformed)
    }
    
    
    
    
}
