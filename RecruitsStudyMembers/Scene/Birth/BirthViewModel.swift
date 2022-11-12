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
    
    var yearValue = PublishRelay<String>()
    var monthValue = PublishRelay<String>()
    var dayValue = PublishRelay<String>()
    
    let dateFormatter = DateFormatter()
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let tap: ControlEvent<Void>
        let date: ControlProperty<Date>
    }
    
    struct Output {
        let tap: ControlEvent<Void>
        let year: SharedSequence<DriverSharingStrategy, String>
        let month: SharedSequence<DriverSharingStrategy, String>
        let day: SharedSequence<DriverSharingStrategy, String>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        input.date
            .asObservable()
            .withUnretained(self)
            .subscribe { (vc, date) in
                vc.dateFormatter.dateFormat = "YYYY"
                vc.yearValue.accept(vc.dateFormatter.string(from: date))
                
                vc.dateFormatter.dateFormat = "MM"
                vc.monthValue.accept(vc.dateFormatter.string(from: date))
                
                vc.dateFormatter.dateFormat = "dd"
                vc.dayValue.accept(vc.dateFormatter.string(from: date))
                
                vc.dateFormatter.locale = Locale(identifier: "ko-KR")
                vc.dateFormatter.timeZone = TimeZone.current
                vc.dateFormatter.dateFormat = "YYYY-MM-dd'T'HH:mm:ss.SSS'Z'"
                
                let finalDate = vc.dateFormatter.string(from: date)
                print(finalDate)
            }
            .disposed(by: disposeBag)

        input.date
            .asObservable()
            .subscribe { date in
                
                print(date)
                let formatter = RelativeDateTimeFormatter()
                formatter.unitsStyle = .full
                let relativeDate = formatter.localizedString(for: date, relativeTo: Date())
                
                print(relativeDate)
                if relativeDate == "17년 전" {
                    print("true")
                }
            }
            .disposed(by: disposeBag)
        
        let year = yearValue.asDriver(onErrorJustReturn: "")
        let month = monthValue.asDriver(onErrorJustReturn: "")
        let day = dayValue.asDriver(onErrorJustReturn: "")
        
        return Output(tap: input.tap, year: year, month: month, day: day)
    }
}
