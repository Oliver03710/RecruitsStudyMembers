//
//  ManageInfoViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import UIKit

import RxCocoa
import RxSwift

final class ManageInfoViewController: BaseViewController {

    // MARK: - Properties
    
    private let myView = ManageInfoView()
    
    
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
    
    
    // MARK: - Selectors
    
    @objc func saveAction() {
        
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNavigationStatus()
        myView.collectionView.delegate = self
    }
    
    func setNavigationStatus() {
        setNaigations(naviTitle: "정보 관리")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveAction))
    }
    
    func bindData() {
        
    }

}


extension ManageInfoViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
//        myView.isHiddens = myView.isHiddens ? false : true
//        myView.count += 1
//        myView.updateUI()
    }
}
