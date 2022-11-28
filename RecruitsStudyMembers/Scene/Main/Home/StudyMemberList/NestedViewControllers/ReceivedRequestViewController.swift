//
//  ReceivedRequestViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

final class ReceivedRequestViewController: BaseViewController {

    // MARK: - Properties
    
    let receivedView = SharedSegmentedView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = receivedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions
    

}
