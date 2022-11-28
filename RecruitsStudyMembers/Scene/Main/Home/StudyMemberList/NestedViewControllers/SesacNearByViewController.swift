//
//  SesacNearByViewController.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/28.
//

import UIKit

final class SesacNearByViewController: BaseViewController {

    // MARK: - Properties
    
    let nearbyView = SharedSegmentedView()
    
    
    // MARK: - Init
    
    override func loadView() {
        view = nearbyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - Helper Functions

}
