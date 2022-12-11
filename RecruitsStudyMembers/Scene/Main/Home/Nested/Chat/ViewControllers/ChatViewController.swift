//
//  ChatViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/04.
//

import UIKit

import SnapKit

final class ChatViewController: BaseViewController {

    // MARK: - Properties
    
    let chatView = ChatView()
    var nickname: String?
    
    
    // MARK: - Init
    
    override func loadView() {
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Selectors
    
    @objc func showMore() {
        chatView.showMoreButtons()
    }
    
    
    // MARK: - Helper Functions
    
    override func configureUI() {
        setNaigations(naviTitle: nickname)
    }
    
    override func setNaigations(naviTitle: String? = nil) {
        super.setNaigations(naviTitle: naviTitle)
        let stopButton = UIBarButtonItem(image: UIImage(named: GeneralIcons.more.rawValue), style: .plain, target: self, action: #selector(showMore))
        
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.rightBarButtonItem = stopButton
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        chatView.showMores = false
        chatView.moreViewHeightConstraint?.update(offset: -76)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.chatView.opaqueView.backgroundColor = UIColor.black.withAlphaComponent(0)
            self?.view.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.chatView.moreView.isHidden = true
            self?.chatView.opaqueView.isHidden = true
        }
    }
}
