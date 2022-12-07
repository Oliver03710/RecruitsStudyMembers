//
//  ChattingData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/07.
//

import Foundation

struct Chat: Codable {
    let id, chat, createdAt, from, to: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case chat, createdAt, from, to
    }
}
