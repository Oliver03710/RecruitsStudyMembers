//
//  ChatManager.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/12/07.
//

import Foundation

import SocketIO

final class ChatManager {
    
    // MARK: - Properties
    
    static let shared = ChatManager()
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    
    // MARK: - Init
    
    private init() {
        guard let url = URL(string: UserDefaultsManager.chatBaseURLPath) else { return }
        manager = SocketManager(socketURL: url, config: [.forceWebsockets(true)])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { [weak self] data, ack in
            guard let self = self else { return }
            print("Socket Is Connected", data, ack)
            self.socket.emit("changesocketid", UserDefaultsManager.myUid)
            
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket Is Disconnected", data, ack)
        }
        
        socket.on("chat") { dataArray, ack in
            print("Sesac Received", dataArray, ack)
            
            guard let data = dataArray[0] as? NSDictionary else { return }
            guard let id = data["_id"] as? String else { return }
            guard let chat = data["chat"] as? String else { return }
            guard let createdAt = data["createdAt"] as? String else { return }
            guard let from = data["from"] as? String else { return }
            guard let to = data["to"] as? String else { return }
            
            print("Check >>>", chat, id, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self,
                                            userInfo: ["id": id,
                                                       "chat": chat,
                                                       "createdAt": createdAt,
                                                       "from": from,
                                                       "to": to])
        }
    }
    
    
    // MARK: - Helper Functions
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
