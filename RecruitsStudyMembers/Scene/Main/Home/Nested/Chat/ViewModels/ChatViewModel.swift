//
//  ChatViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/04.
//

import Foundation

import RxCocoa
import RxSwift

final class ChatViewModel: CommonViewModel {
    
    // MARK: - Properties
    
    var dateSection = BehaviorRelay<[ChatSections]>(value: [])
    
    var usersChat = BehaviorRelay<[ChatSections]>(value: [])
    var myChat = BehaviorRelay<[ChatSections]>(value: [])
    
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
