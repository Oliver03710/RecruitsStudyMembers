//
//  SearchViewModel.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/27.
//

import UIKit

import RxCocoa
import RxSwift

final class SearchViewModel: CommonViewModel {

    // MARK: - Properties
    
    var numberOfRecommend = BehaviorRelay<Int>(value: 0)
    
    let disposeBag = DisposeBag()
    
    
    // MARK: - In & Out Data
    
    struct Input {
        let textDidBeginEditing: ControlEvent<Void>
        let textDidEndEditing: ControlEvent<Void>
        let seekButtonTapped: ControlEvent<Void>
        let accButtonTapped: ControlEvent<Void>
        let searchButtonClicked: ControlEvent<Void>
    }
    
    struct Output {
        let textEditingAction : SharedSequence<DriverSharingStrategy, TextFieldActions>
        let actionsCombined : SharedSequence<DriverSharingStrategy, ButtonCombined>
        let searchButtonDriver: SharedSequence<DriverSharingStrategy, ButtonCombined>
    }
    
    
    // MARK: - Helper Functions
    
    func transform(input: Input) -> Output {
        
        let actionsCombined = Observable.merge(input.seekButtonTapped.map { _ in ButtonCombined.action1 },
                         input.accButtonTapped.map { _ in ButtonCombined.action2 })
        .asDriver(onErrorJustReturn: .action1)
        
        let textEditingAction = Observable.merge(input.textDidBeginEditing.map { _ in TextFieldActions.editingDidBegin },
                                                 input.textDidEndEditing.map { _ in TextFieldActions.editingDidEnd })
        .asDriver(onErrorJustReturn: .editingDidBegin)
        
        let searchButtonDriver = input.searchButtonClicked.map { _ in ButtonCombined.action1 }.asDriver(onErrorJustReturn: .action1)
       
        return Output(textEditingAction: textEditingAction, actionsCombined: actionsCombined, searchButtonDriver: searchButtonDriver)
    }
    
}
