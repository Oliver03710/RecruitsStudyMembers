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
        let input = BirthViewModel.Input(tap: birthView.nextButton.rx.tap,
                                         date: birthView.datePicker.rx.date)
        
        let output = birthView.viewModel.transform(input: input)

        output.dateTransformed
            .drive { [weak self] date in
                guard let year = date?.year, let month = date?.month, let day = date?.day else { return }
                self?.birthView.leftView.birthTextField.text = "\(year)"
                self?.birthView.centerView.birthTextField.text = "\(month)"
                self?.birthView.rightView.birthTextField.text = "\(day)"
            }
            .disposed(by: birthView.viewModel.disposeBag)
        
        output.ageValid
            .withUnretained(self)
            .bind { (vc, bool) in
                vc.birthView.nextButton.backgroundColor = bool ? SSColors.green.color : SSColors.gray6.color
            }
            .disposed(by: birthView.viewModel.disposeBag)
        
        output.tap
            .drive { [weak self] _ in
                output.buttonValid.value ? self?.toNextPage() : self?.view.makeToast("새싹스터디는 만 17세 이상만 사용할 수 있습니다.", position: .top)
            }
            .disposed(by: birthView.viewModel.disposeBag)

    }
    
    func toNextPage() {
        let vc = EmailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
