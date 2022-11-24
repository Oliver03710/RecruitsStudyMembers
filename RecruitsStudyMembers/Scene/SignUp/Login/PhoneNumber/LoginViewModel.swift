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
    
    private var buttonValid = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let textFieldText: ControlProperty<String?>
        let textFieldIsEditing: ControlEvent<Void>
        let textFieldFiniedEditing: ControlEvent<Void>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let phoneNum: Observable<Bool>
        let isEditing: Observable<Bool>
        let textChanged: Observable<ControlProperty<String>.Element>
        let tapDriver: SharedSequence<DriverSharingStrategy, Void>
        let textFieldActions: Observable<TextFieldActions>
        let buttonValid: BehaviorRelay<Bool>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let textFormat = input.textFieldText.orEmpty.changed
            .map { str in
                print(str)
                var numbersOnly = str.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                let length = numbersOnly.count
                
                if length >= 12 {
                    numbersOnly.insert("-", at: numbersOnly.index(numbersOnly.startIndex, offsetBy: 3))
                    numbersOnly.insert("-", at: numbersOnly.index(numbersOnly.startIndex, offsetBy: 8))
                    let maxStr = numbersOnly.index(numbersOnly.startIndex, offsetBy: 13)
                    return String(numbersOnly[..<maxStr])
                    
                } else if length >= 7 && length < 12 {
                    numbersOnly.insert("-", at: numbersOnly.index(numbersOnly.startIndex, offsetBy: 3))
                    length == 11 ? numbersOnly.insert("-", at: numbersOnly.index(numbersOnly.startIndex, offsetBy: 8)) :
                    numbersOnly.insert("-", at: numbersOnly.index(numbersOnly.startIndex, offsetBy: 7))
                    return numbersOnly
                    
                } else if length >= 4 && length < 7 {
                    numbersOnly.insert("-", at: numbersOnly.index(numbersOnly.startIndex, offsetBy: 3))
                    return numbersOnly
                }
                
                return numbersOnly
            }
            .share()
        
        let numValid = textFormat
            .withUnretained(self)
            .map { vc, str in
                let phoneNumRegEx = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
                let numTest = NSPredicate(format:"SELF MATCHES %@", phoneNumRegEx)
                
                if numTest.evaluate(with: str) {
                    let phoneNum = str.dropFirst().components(separatedBy: "-").joined()
                    UserDefaultsManager.phoneNum = "+82\(phoneNum)"
                    print(UserDefaultsManager.phoneNum)
                    vc.buttonValid.accept(true)
                }
                return numTest.evaluate(with: str)
            }
        
        let textFieldActions = Observable.merge(input.textFieldIsEditing.map { _ in TextFieldActions.editingDidBegin },
                                                input.textFieldFiniedEditing.map { _ in TextFieldActions.editingDidEnd })
        
        
        let isEditing = input.textFieldIsEditing
            .scan(true, accumulator: { bool, _ in
                return bool
            })
            .asObservable()
        
        let tapDriver = input.tap.asDriver()
        
        return Output(phoneNum: numValid, isEditing: isEditing, textChanged: textFormat, tapDriver: tapDriver, textFieldActions: textFieldActions, buttonValid: buttonValid)
    }
}


