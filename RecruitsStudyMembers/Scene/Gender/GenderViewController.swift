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
        let input = GenderViewModel.Input(tap: genderView.nextButton.rx.tap)
        let output = genderView.viewModel.transform(input: input)

        output.tap
            .withUnretained(self)
            .bind { (vc, _) in
                vc.toNextPage()
            }
            .disposed(by: genderView.viewModel.disposeBag)
    }
    
    func toNextPage() {
//        let vc = GenderViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}
