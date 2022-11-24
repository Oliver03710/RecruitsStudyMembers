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
    
    private var buttonValid = BehaviorRelay<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
        let date: ControlProperty<Date>
    }
    
    struct Output {
        let tap: SharedSequence<DriverSharingStrategy, Void>
        let dateTransformed: SharedSequence<DriverSharingStrategy, (year: Int?, month: Int?, day: Int?)?>
        let ageValid: Observable<Bool>
        let buttonValid: BehaviorRelay<Bool>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let dateTransformed = input.date
            .map { date in
                date.toCalendar()
            }
            .asDriver(onErrorJustReturn: nil)
        
        let ageValid = input.date
            .withUnretained(self)
            .map { vc, date in
                
                guard let year = date.toCalendar().year, let month = date.toCalendar().month, let day = date.toCalendar().day else {
                    vc.buttonValid.accept(false)
                    return false
                }
                
                if date.calculateDates().year > 17 {
                    vc.buttonValid.accept(true)
                    UserDefaultsManager.birth = date.toString()
                    UserDefaultsManager.birthYear = "\(year)"
                    UserDefaultsManager.birthMonth = "\(month)"
                    UserDefaultsManager.birthDay = "\(day)"
                    return true
                }
                
                guard date.calculateDates().year == 17 else {
                    vc.buttonValid.accept(false)
                    return false
                }
                
                guard date.calculateDates().month >= 0 else {
                    vc.buttonValid.accept(false)
                    return false
                }
                
                guard date.calculateDates().day >= 0 else {
                    vc.buttonValid.accept(false)
                    return false
                }
                
                vc.buttonValid.accept(true)
                UserDefaultsManager.birth = date.toString()
                UserDefaultsManager.birthYear = "\(year)"
                UserDefaultsManager.birthMonth = "\(month)"
                UserDefaultsManager.birthDay = "\(day)"
                return true
            }
        
        let tap = input.tap.asDriver()
        
        return Output(tap: tap, dateTransformed: dateTransformed, ageValid: ageValid, buttonValid: buttonValid)
    }
}
