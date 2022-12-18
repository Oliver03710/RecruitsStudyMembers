//
//  ShopViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import Foundation

import RxCocoa
import RxSwift

final class ShopViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let saveButtonTapped: ControlEvent<Void>
    }
    
    struct Output {
        let saveButtonDriver: SharedSequence<DriverSharingStrategy, Void>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
       
        let saveButtonDriver = input.saveButtonTapped.asDriver()
        
        return Output(saveButtonDriver: saveButtonDriver)
    }
}
