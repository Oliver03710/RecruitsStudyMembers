//
//  ChatRealm+Repository.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/07.
//

import Foundation

import RealmSwift

private protocol ChatRepositoryType: AnyObject {
    func fetchData()
    func addItem(id: String, chat: String, createdAt: String, from: String, to: String)
    func deleteAll()
}

final class ChatRepository: ChatRepositoryType {
    
    // MARK: - Properties
    
    static let shared = ChatRepository()
    
    let localRealm = try! Realm()
    var tasks: Results<ChatRealm>!
    
    
    // MARK: - Init
    
    private init() { }
    
    
    // MARK: - Helper Functions
    
    func fetchData() {
        tasks = localRealm.objects(ChatRealm.self)
    }
    
    func addItem(id: String, chat: String, createdAt: String, from: String, to: String) {
        let task = ChatRealm(id: id, chat: chat, createdAt: createdAt, from: from, to: to)
        
        do {
            try localRealm.write {
                localRealm.add(task)
            }
            
        } catch let error {
            print("데이터 추가 실패", error.localizedDescription)
        }
    }
    
    func deleteAll() {
        do {
            try localRealm.write {
                localRealm.deleteAll()
            }
            
        } catch let error {
            print("전체 삭제 실패", error.localizedDescription)
        }
    }
}
