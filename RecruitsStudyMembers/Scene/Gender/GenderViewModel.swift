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
    
    private var genderValue = BehaviorRelay<Int>(value: UserDefaultsManager.gender)
    private var maleSelected = BehaviorRelay<Bool>(value: UserDefaultsManager.maleSelected)
    private var buttonValid = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
        let maleTapped: ControlEvent<Void>
        let femaleTapped: ControlEvent<Void>
    }
    
    struct Output {
        let tap: SharedSequence<DriverSharingStrategy, Void>
        let maleSelected: SharedSequence<DriverSharingStrategy, Bool>
        let buttonValid: BehaviorRelay<Bool>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        Observable.merge(input.maleTapped.map { GenderButtonTapped.male},
                         input.femaleTapped.map { GenderButtonTapped.female})
        .withUnretained(self)
        .subscribe { vc, action in
            switch action {
            case .male:
                vc.genderValue.accept(1)
                vc.maleSelected.accept(true)
                UserDefaultsManager.maleSelected = true
                UserDefaultsManager.gender = 1
            case .female:
                vc.genderValue.accept(0)
                vc.maleSelected.accept(false)
                UserDefaultsManager.maleSelected = false
                UserDefaultsManager.gender = 0
            }
            vc.buttonValid.accept(true)
        }
        .disposed(by: disposeBag)
        
        let tap = input.tap.asDriver()
        
        let maleSelected = maleSelected.asDriver(onErrorJustReturn: false)
        
        return Output(tap: tap, maleSelected: maleSelected, buttonValid: buttonValid)
    }
}
