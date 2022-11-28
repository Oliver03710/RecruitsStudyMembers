//
//  SearchData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/27.
//

import Foundation

struct SearchData: Hashable {
    let title: String
    let identifier = UUID()
    
    init(title: String) {
        self.title = title
    }
}
