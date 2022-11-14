//
//  BirthViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/10.
//

import Foundation

import RxCocoa
import RxSwift

final class BirthViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    private var yearValue = BehaviorRelay<String>(value: UserDefaultsManager.birthYear)
    private var monthValue = BehaviorRelay<String>(value: UserDefaultsManager.birthMonth)
    private var dayValue = BehaviorRelay<String>(value: UserDefaultsManager.birthDay)
    private var buttonValid = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
        let date: ControlProperty<Date>
    }
    
    struct Output {
        let tap: SharedSequence<DriverSharingStrategy, Void>
        let year: SharedSequence<DriverSharingStrategy, String>
        let month: SharedSequence<DriverSharingStrategy, String>
        let day: SharedSequence<DriverSharingStrategy, String>
        let ageValid: Observable<Bool>
        let buttonValid: BehaviorRelay<Bool>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        input.date
            .asObservable()
            .withUnretained(self)
            .subscribe { (vc, date) in
                vc.yearValue.accept(date.toString(withFormat: "YYYY"))
                vc.monthValue.accept(date.toString(withFormat: "MM"))
                vc.dayValue.accept(date.toString(withFormat: "dd"))
            }
            .disposed(by: disposeBag)

        let ageValid = input.date
            .asObservable()
            .withUnretained(self)
            .map { vc, date in
                guard let yearInterval = (Date()-date).year else { return false }
                guard let monthInterval = (Date()-date).month else { return false }
                guard let dayInterval = (Date()-date).day else { return false }
                
                UserDefaultsManager.birthYear = date.toString(withFormat: "YYYY")
                UserDefaultsManager.birthMonth = date.toString(withFormat: "MM")
                UserDefaultsManager.birthDay = date.toString(withFormat: "dd")
                
                UserDefaultsManager.birth = date.toString()
                
                guard yearInterval <= 17 else {
                    vc.buttonValid.accept(true)
                    return true
                }
                
                guard monthInterval % 12 <= 0 else {
                    vc.buttonValid.accept(true)
                    return true
                }
                
                guard dayInterval % 30 < 0 else {
                    vc.buttonValid.accept(true)
                    return true
                }
                return false
            }
        
        let tap = input.tap.asDriver()
        
        let year = yearValue.asDriver(onErrorJustReturn: "")
        let month = monthValue.asDriver(onErrorJustReturn: "")
        let day = dayValue.asDriver(onErrorJustReturn: "")
        
        return Output(tap: tap, year: year, month: month, day: day, ageValid: ageValid, buttonValid: buttonValid)
    }
}
