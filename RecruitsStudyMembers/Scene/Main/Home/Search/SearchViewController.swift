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
    
    let myView = SearchView()
    
    
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
        
        let input = SearchViewModel.Input(textDidBeginEditing: myView.searchBar.rx.textDidBeginEditing,
                                          textDidEndEditing: myView.searchBar.rx.textDidEndEditing,
                                          seekButtonTapped: myView.seekButton.rx.tap,
                                          accButtonTapped: myView.accButton.rx.tap)
        
        let output = myView.viewModel.transform(input: input)
        
        
        output.textEditingAction
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
        .disposed(by: myView.viewModel.disposeBag)
        
        output.actionsCombined
            .drive { [weak self] _ in
                guard let self = self else { return }
                self.showListTapped()
            }
            .disposed(by: myView.viewModel.disposeBag)
    }
    
    private func showListTapped() {
        let vc = MemberListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
