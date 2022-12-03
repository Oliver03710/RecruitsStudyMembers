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
    
    private var emailValue = BehaviorRelay<String>(value: UserDefaultsManager.email)
    private var buttonValid = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
        let emailText: ControlProperty<String?>
    }
    
    struct Output {
        let tap: SharedSequence<DriverSharingStrategy, Void>
        let emailValid: Observable<Bool>
        let buttonValid: BehaviorRelay<Bool>
        let emailValue: SharedSequence<DriverSharingStrategy, String>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let emailValid = input.emailText.orEmpty
            .withUnretained(self)
            .map { vc, str in
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                UserDefaultsManager.email = str
                if emailTest.evaluate(with: str) {
                    vc.buttonValid.accept(true)
                }
                return emailTest.evaluate(with: str)
            }
        
        let tap = input.tap.asDriver()
        
        let emailValue = emailValue.asDriver(onErrorJustReturn: "")
        
        return Output(tap: tap, emailValid: emailValid, buttonValid: buttonValid, emailValue: emailValue)
    }
}
