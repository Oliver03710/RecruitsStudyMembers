//
//  ShopSharedViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/15.
//

import Foundation

import RxCocoa
import RxSwift

final class ShopSharedViewModel: CommonViewModel {

    // MARK: - Properties
    
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
