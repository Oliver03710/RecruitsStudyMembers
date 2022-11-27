//
//  SearchViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/21.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SearchViewController: BaseViewController {
    
    // MARK: - Properties
    
    private let myView = SearchView()
    private let disposeBag = DisposeBag()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = myView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        settingNavibars()
        bindData()
    }
    
    private func settingNavibars() {
        let navigationBar = navigationController?.navigationBar
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.shadowColor = .clear
        navigationBarAppearance.backgroundColor = SSColors.white.color
        navigationBar?.scrollEdgeAppearance = navigationBarAppearance
        
        navigationItem.title = nil
        navigationController?.navigationBar.tintColor = SSColors.black.color
        navigationController?.isNavigationBarHidden = false
        
        let backButton = UIBarButtonItem(image: UIImage(named: GeneralIcons.arrow.rawValue), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem  = backButton
        
        navigationItem.titleView = myView.searchBar
    }
    
    private func bindData() {
        Observable.merge(myView.searchBar.rx.textDidBeginEditing.map { _ in TextFieldActions.editingDidBegin },
                         myView.searchBar.rx.textDidEndEditing.map { _ in TextFieldActions.editingDidEnd })
        .asDriver(onErrorJustReturn: .editingDidBegin)
        .drive { [weak self] actions in
            guard let self = self else { return }
            switch actions {
            case .editingDidBegin:
                self.myView.seekButton.isHidden = true
                self.myView.searchBar.searchTextField.inputAccessoryView = self.myView.accButton
                
            case .editingDidEnd:
                self.myView.seekButton.isHidden = false
            }
        }
        .disposed(by: disposeBag)

    }
}
