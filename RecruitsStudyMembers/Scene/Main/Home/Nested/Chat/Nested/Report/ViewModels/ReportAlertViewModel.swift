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
        
        let textViewEditingBegan: ControlEvent<Void>
        let textViewEditingDidEnd: ControlEvent<Void>
        
        let executionButtonTapped: ControlEvent<Void>
        
        let textViewString: ControlProperty<String>
    }
    
    struct Output {
        let xmarkButtonDriver: SharedSequence<DriverSharingStrategy, Void>
        let alertViewButtonMergedDriver: SharedSequence<DriverSharingStrategy, AlertViewButtonCombined>
        let textViewDriver: SharedSequence<DriverSharingStrategy, TextFieldActions>
        let executionButtonDriver: SharedSequence<DriverSharingStrategy, Void>
        let executionButtonValid: SharedSequence<DriverSharingStrategy, Bool>
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
        
        let textViewDriver = Observable.merge(input.textViewEditingBegan.map { _ in TextFieldActions.editingDidBegin },
                         input.textViewEditingDidEnd.map { _ in TextFieldActions.editingDidEnd })
        .asDriver(onErrorJustReturn: .editingDidBegin)
        
        let executionButtonDriver = input.executionButtonTapped.asDriver()
        
        let executionButtonValid = input.textViewString
            .map({ str in
                str.isEmpty
            })
            .asDriver(onErrorJustReturn: false)
       
        return Output(xmarkButtonDriver: xmarkButtonDriver,
                      alertViewButtonMergedDriver: alertViewButtonMergedDriver,
                      textViewDriver: textViewDriver,
                      executionButtonDriver: executionButtonDriver,
                      executionButtonValid: executionButtonValid)
    }
}
