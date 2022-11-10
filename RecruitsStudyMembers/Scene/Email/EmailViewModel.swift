//
//  EmailViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

import RxCocoa
import RxSwift

final class EmailViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
        let emailText: ControlProperty<String?>
    }
    
    struct Output {
        let tap: ControlEvent<Void>
        let emailValid: Observable<Bool>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let emailValid = input.emailText.orEmpty
            .map { str in
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailTest.evaluate(with: str)
            }
        
        return Output(tap: input.tap, emailValid: emailValid)
    }
}
