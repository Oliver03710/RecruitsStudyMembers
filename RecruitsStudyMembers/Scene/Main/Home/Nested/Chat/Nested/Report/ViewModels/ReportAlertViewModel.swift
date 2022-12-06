//
//  ReportAlertViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/06.
//

import Foundation

import RxCocoa
import RxSwift

final class ReportAlertViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let xmarkButtonTapped: ControlEvent<Void>
        
        let illigalOrMannerButtonTapped: ControlEvent<Void>
        let unpleasantOrAppointmentButtonTapped: ControlEvent<Void>
        let noShowOrResponseButtonTapped: ControlEvent<Void>
        let sexualOrKindButtonTapped: ControlEvent<Void>
        let harrasmentOrSkilledButtonTapped: ControlEvent<Void>
        let etcOrGoodtimeButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let xmarkButtonDriver: SharedSequence<DriverSharingStrategy, Void>
        let alertViewButtonMergedDriver: SharedSequence<DriverSharingStrategy, AlertViewButtonCombined>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let xmarkButtonDriver = input.xmarkButtonTapped.asDriver()
        
        let alertViewButtonMergedDriver = Observable.merge(input.illigalOrMannerButtonTapped.map { AlertViewButtonCombined.illigalOrManner },
                         input.unpleasantOrAppointmentButtonTapped.map { AlertViewButtonCombined.unpleasantOrAppointment },
                         input.noShowOrResponseButtonTapped.map { AlertViewButtonCombined.noShowOrResponse },
                         input.sexualOrKindButtonTapped.map { AlertViewButtonCombined.sexualOrKind },
                         input.harrasmentOrSkilledButtonTapped.map { AlertViewButtonCombined.harrasmentOrSkilled },
                         input.etcOrGoodtimeButtonTapped.map { AlertViewButtonCombined.etcOrGoodtime })
        .asDriver(onErrorJustReturn: .illigalOrManner)
       
        return Output(xmarkButtonDriver: xmarkButtonDriver,
                      alertViewButtonMergedDriver: alertViewButtonMergedDriver)
    }
}
