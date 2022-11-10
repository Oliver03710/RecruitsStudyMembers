//
//  NicknameViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

import RxCocoa
import RxSwift

final class NicknameViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
        let textFieldText: ControlProperty<String?>
    }
    
    struct Output {
        let tap: ControlEvent<Void>
        let textValid: Observable<Bool>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let nicknameValid = input.textFieldText
            .orEmpty
            .map { $0.count <= 10 && !$0.isEmpty }
        
        return Output(tap: input.tap, textValid: nicknameValid)
    }
}
