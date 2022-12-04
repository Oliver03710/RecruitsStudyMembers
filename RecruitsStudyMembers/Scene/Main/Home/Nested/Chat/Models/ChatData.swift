//
//  ChatData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/04.
//

import Differentiator

struct ChatSections {
    var items: [Item]
}

enum ChatItems {
    case chatCell(ChatCellModel)
}

extension ChatSections: SectionModelType {
    typealias Item = ChatItems
    
    init(original: ChatSections, items: [Item] = []) {
        self = original
        self.items = items
    }
}

struct ChatCellModel {
    let string: String
}
