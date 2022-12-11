//
//  ChatRealm.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/07.
//

import Foundation

import RealmSwift

final class ChatRealm: Object, Codable {
    
    // MARK: - Enum (Coding Keys)
    
    private enum CodingKeys: String, CodingKey {
        case id = "_id"
        case chat, createdAt, from, to
    }
    
    
    // MARK: - Properties
    
    @Persisted var id: String
    @Persisted var chat: String
    @Persisted var createdAt: String
    @Persisted var from: String
    @Persisted var to: String
    
    @Persisted(primaryKey: true) var objectId: ObjectId
    
    
    // MARK: - Init
    
    convenience init(id: String, chat: String, createdAt: String, from: String, to: String) {
        self.init()
        self.id = id
        self.chat = chat
        self.createdAt = createdAt
        self.from = from
        self.to = to
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.chat = try container.decode(String.self, forKey: .chat)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
        self.from = try container.decode(String.self, forKey: .from)
        self.to = try container.decode(String.self, forKey: .to)
    }
    
    
    // MARK: - Helper Functions
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        try container.encode(self.chat, forKey: .chat)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encode(self.from, forKey: .from)
        try container.encode(self.to, forKey: .to)
    }
}
