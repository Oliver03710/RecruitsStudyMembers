//
//  CustomAlertViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/02.
//

import Foundation

import RxCocoa
import RxSwift

final class CustomAlertViewModel: CommonViewModel {

    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let cancelButtonTapped: ControlEvent<Void>
        let confirmButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let cancelButtonDriver: SharedSequence<DriverSharingStrategy, Void>
        let confirmButtonDriver: SharedSequence<DriverSharingStrategy, Void>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let cancelButtonDriver = input.cancelButtonTapped.asDriver()
        let confirmButtonDriver = input.confirmButtonTapped.asDriver()
        
        return Output(cancelButtonDriver: cancelButtonDriver, confirmButtonDriver: confirmButtonDriver)
    }
    
}
