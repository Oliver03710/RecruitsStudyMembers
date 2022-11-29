//
//  ReceivedViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/30.
//

import Foundation

import RxCocoa
import RxSwift

final class ReceivedViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    var receivedList = BehaviorRelay<[MemberListData]>(value: [])
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
    }
    
    struct Output {
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
       
        return Output()
    }
}
