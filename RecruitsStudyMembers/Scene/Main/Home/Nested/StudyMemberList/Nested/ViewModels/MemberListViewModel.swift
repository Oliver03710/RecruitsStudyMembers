//
//  NearByViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/30.
//

import Foundation

import RxCocoa
import RxSwift

final class MemberListViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    var memberList = BehaviorRelay<[MemberListData]>(value: [])
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let changeStudyButtonTapped: ControlEvent<Void>
        let refreshButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let changeStudyButtonDriver: SharedSequence<DriverSharingStrategy, Void>
        let refreshButtonDriver: SharedSequence<DriverSharingStrategy, Void>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let changeStudyButtonDriver = input.changeStudyButtonTapped.asDriver()
        let refreshButtonDriver = input.refreshButtonTapped.asDriver()
        
        return Output(changeStudyButtonDriver: changeStudyButtonDriver, refreshButtonDriver: refreshButtonDriver)
    }
}
