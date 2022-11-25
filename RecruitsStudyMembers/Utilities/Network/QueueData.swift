//
//  QueueData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/25.
//

import Foundation

struct QueueData: Codable {
    var fromQueueDB, fromQueueDBRequested: [FromQueueDB]
    var fromRecommend: [String]
}

struct FromQueueDB: Codable {
    var uid, nick: String
    var lat, long: Double
    var reputation: [Int]
    var studylist, reviews: [String]
    var gender, type, sesac, background: Int
}
