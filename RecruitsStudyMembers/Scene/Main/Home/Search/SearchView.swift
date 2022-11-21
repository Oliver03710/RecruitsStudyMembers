//
//  SearchView.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/21.
//

import UIKit

import SnapKit

final class SearchView: BaseView {
    
    // MARK: - Properties
    
    let seekButton: CustomButton = {
        let btn = CustomButton(text: "새싹 찾기", buttonColor: SSColors.green.color)
        return btn
    }()
    
    let accButton: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 48))
        btn.backgroundColor = SSColors.green.color
        btn.setTitle("새싹 찾기", for: .normal)
        return btn
    }()
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.sizeToFit()
        return sb
    }()
    
    let tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer()
        return tap
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    // MARK: - Helper Functions
    
    override func setConstraints() {
        addSubview(seekButton)
        addGestureRecognizer(tap)
        
        seekButton.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(48)
        }
    }

}
