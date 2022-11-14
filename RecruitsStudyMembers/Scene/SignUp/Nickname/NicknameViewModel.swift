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
    
    private var buttonValid = BehaviorRelay<Bool>(value: false)
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
        let textFieldText: ControlProperty<String?>
    }
    
    struct Output {
        let tapDriver: SharedSequence<DriverSharingStrategy, Void>
        let textValid: Observable<Bool>
        let textTransformed: Observable<String>
        let buttonValid: BehaviorRelay<Bool>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let textTransformed = input.textFieldText
            .orEmpty
            .map { $0.components(separatedBy: " ").joined() }
            .share()
        
        let nicknameValid = textTransformed
            .map { $0.count <= 10 && !$0.isEmpty }
            .share()
        
        nicknameValid
            .withUnretained(self)
            .subscribe { vc, bool in
                vc.buttonValid.accept(true)
            }
            .disposed(by: disposeBag)
        
        let tapDriver = input.tap.asDriver()
        
        return Output(tapDriver: tapDriver, textValid: nicknameValid, textTransformed: textTransformed, buttonValid: buttonValid)
    }
}
