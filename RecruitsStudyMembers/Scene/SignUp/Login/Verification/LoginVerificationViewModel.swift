//
//  LoginVerificationViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/25.
//

import Foundation

import RxCocoa
import RxSwift

final class LoginVerificationViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let startButtonTapped: ControlEvent<Void>
        let resetButtonTapped: ControlEvent<Void>
        let textFieldText: ControlProperty<String?>
    }
    
    struct Output {
        let textValid: Observable<Bool>
        let startButtonTapped: ControlEvent<Void>
        let resetButtonTapped: ControlEvent<Void>
        let textChanged: SharedSequence<DriverSharingStrategy, String>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let shareText = input.textFieldText
            .orEmpty
            .map { str in
                let numbersOnly = str.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                let length = numbersOnly.count
                
                guard length > 4 else { return str }
                
                let sourceIndex = 0
                
                let suffixLength = 6
                guard let num = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else { return str }

                return num
            }
            .share()
        
        let textValid = shareText
            .map { $0.count == 6 }
        
        let textChanged = shareText
            .asDriver(onErrorJustReturn: "")
        
        shareText
            .bind { str in
                if str.count == 6 {
                    UserDefaultsManager.certiNum = str
                }
            }
            .disposed(by: disposeBag)
        
        return Output(textValid: textValid, startButtonTapped: input.startButtonTapped, resetButtonTapped: input.resetButtonTapped, textChanged: textChanged)
    }
}
