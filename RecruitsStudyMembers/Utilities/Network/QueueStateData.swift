//
//  QueueStateData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/03.
//

import Foundation

struct QueueStateData: Codable {
    let reviewed, matched, dodged: Int
    let matchedNick, matchedUid: String?
}
