//
//  HomeViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import Foundation

import RxCocoa
import RxSwift

final class HomeViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    var members = PublishRelay<[FromQueueDB]>()
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let currentButtonTapped: ControlEvent<Void>
        let seekButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let currentButtonDriver : SharedSequence<DriverSharingStrategy, Void>
        let seekButtonDriver: SharedSequence<DriverSharingStrategy, Void>
        let memberDriver: SharedSequence<DriverSharingStrategy, [FromQueueDB]>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let currentButtonDriver = input.currentButtonTapped.asDriver()
        let seekButtonDriver = input.seekButtonTapped.asDriver()
        let memberDriver = members.asDriver(onErrorJustReturn: [])
       
        return Output(currentButtonDriver: currentButtonDriver, seekButtonDriver: seekButtonDriver, memberDriver: memberDriver)
    }
}
