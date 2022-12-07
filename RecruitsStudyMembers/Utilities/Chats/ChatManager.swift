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
        
        socket.on(clientEvent: .connect) { data, ack in
            print("Socket Is Connected", data, ack)
        }
        
        socket.on(clientEvent: .disconnect) { data, ack in
            print("Socket Is Disconnected", data, ack)
        }
        
        socket.on("sesac") { dataArray, ack in
            print("Sesac Received", dataArray, ack)
            
            guard let data = dataArray[0] as? NSDictionary else { return }
            guard let chat = data["text"] as? String else { return }
            guard let name = data["name"] as? String else { return }
            guard let userId = data["userId"] as? String else { return }
            guard let createdAt = data["createdAt"] as? String else { return }
            
            print("Check >>>", chat, name, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self,
                                            userInfo: ["chat": chat,
                                                       "name": name,
                                                       "createdAt": createdAt,
                                                       "userId": userId])
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
