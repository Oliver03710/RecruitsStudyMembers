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
    case dateCell(DateCellModel)
    case userChatCell(UserChatCellModel)
    case introCell(IntroCellModel)
    case myChatCell(MyChatCellModel)
}

extension ChatSections: SectionModelType {
    typealias Item = ChatItems
    
    init(original: ChatSections, items: [Item] = []) {
        self = original
        self.items = items
    }
}

struct UserChatCellModel {
    let chat: String
    let date: String
}

struct DateCellModel {
    let string: String
}

struct IntroCellModel {
    let string: String
}

struct MyChatCellModel {
    let chat: String
    let date: String
}
