//
//  GenderViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/08.
//

import UIKit

import RxCocoa
import RxSwift

final class GenderViewController: BaseViewController {

    // MARK: - Properties
    
    private let genderView = GenderView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = genderView
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
        let input = GenderViewModel.Input(tap: genderView.nextButton.rx.tap, maleTapped: genderView.maleButton.rx.tap, femaleTapped: genderView.femaleButton.rx.tap)
        let output = genderView.viewModel.transform(input: input)
        
        output.maleSelected
            .drive { [weak self] bool in
                self?.genderView.maleButton.backgroundColor = bool ? SSColors.whiteGreen.color : SSColors.white.color
                self?.genderView.maleButton.layer.borderColor = bool ? SSColors.whiteGreen.color.cgColor : SSColors.gray3.color.cgColor
                
                self?.genderView.femaleButton.backgroundColor = bool ? SSColors.white.color : SSColors.whiteGreen.color
                self?.genderView.femaleButton.layer.borderColor = bool ? SSColors.gray3.color.cgColor : SSColors.whiteGreen.color.cgColor
            }
            .disposed(by: genderView.viewModel.disposeBag)
        
        output.tap
            .drive { [weak self] _ in
                output.buttonValid.value ? self?.toNextPage() : self?.view.makeToast("성별을 선택해주세요.", position: .top)
            }
            .disposed(by: genderView.viewModel.disposeBag)
        
    }
    
    func toNextPage() {
        view.makeToast("회원가입을 진행하시겠습니까?", position: .top) { didTap in
            if didTap {
                print("YES")
            }
        }
//        let vc = GenderViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}
