//
//  BirthViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import RxCocoa
import RxSwift
import Toast

final class BirthViewController: BaseViewController {

    // MARK: - Properties
    
    private let birthView = BirthView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = birthView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations()
        bindData()
    }
    
    func bindData() {
        let input = BirthViewModel.Input(tap: birthView.nextButton.rx.tap, date: birthView.datePicker.rx.date)
        let output = birthView.viewModel.transform(input: input)

        output.year
            .drive(birthView.leftView.birthTextField.rx.text)
            .disposed(by: birthView.viewModel.disposeBag)
        
        output.month
            .drive(birthView.centerView.birthTextField.rx.text)
            .disposed(by: birthView.viewModel.disposeBag)
        
        output.day
            .drive(birthView.rightView.birthTextField.rx.text)
            .disposed(by: birthView.viewModel.disposeBag)
        
        output.ageValid
            .withUnretained(self)
            .bind { (vc, bool) in
                vc.birthView.nextButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: birthView.viewModel.disposeBag)
        
        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                output.buttonValid.value ? vc.toNextPage() : vc.view.makeToast("만 17세 미만입니다.", position: .top)
                
            }
            .disposed(by: birthView.viewModel.disposeBag)

    }
    
    func toNextPage() {
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
