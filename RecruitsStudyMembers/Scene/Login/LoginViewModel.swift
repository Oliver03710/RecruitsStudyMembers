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
    
    let checkValid = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let textFieldText: ControlProperty<String?>
        let textFieldIsEditing: ControlEvent<()>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let phoneNum: Observable<Bool>
        let isEditing: Observable<Bool>
        let textChanged: Observable<ControlProperty<String>.Element>
        let tap: ControlEvent<Void>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let textFormat = input.textFieldText.orEmpty
            .map { str in
                
                let numbersOnly = str.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
                let length = numbersOnly.count
                
                guard length > 4 else { return str }
                
                var sourceIndex = 0
                
                let leadingLength = 3
                guard let leading = numbersOnly.substring(start: sourceIndex, offsetBy: leadingLength) else { return str }
                sourceIndex += leadingLength
                
                let prefixLength = length > 10 ? 4 : 3
                guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else { return str }
                sourceIndex += prefixLength
                
                let suffixLength = 4
                guard let suffix = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else { return str }
                
                return leading + "-" + prefix + "-" + suffix
            }
        
        let numValid = input.textFieldText.orEmpty
            .map { str in
                let phoneNumRegEx = "^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$"
                let numTest = NSPredicate(format:"SELF MATCHES %@", phoneNumRegEx)
                return numTest.evaluate(with: str)
            }
            .share()
        
//        numberValid
//            .withUnretained(self)
//            .bind { (vc, bool) in
//                vc.checkValid.accept(bool)
//            }
//            .disposed(by: disposeBag)
        
//        numberValid
//            .withUnretained(self)
//            .bind { (vc, bool) in
//                <#code#>
//            }
//            .disposed(by: disposeBag)
        
        
        let isEditing = input.textFieldIsEditing
            .scan(true, accumulator: { bool, _ in
                return bool
            })
            .asObservable()
        
//        let numValid = checkValid
//            .asObservable()
        
        return Output(phoneNum: numValid, isEditing: isEditing, textChanged: textFormat, tap: input.tap)
    }
}


