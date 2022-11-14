//
//  MyInfoData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import Foundation

struct MyInfo: Hashable {
    let title: String
    let image: String
    let identifier = UUID()
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
    
    static func itemsInternal() -> [MyInfo] {
        return [ MyInfo(title: "이름", image: FaceImages.sesacFace1.rawValue),
                 MyInfo(title: "공지사항", image: GeneralIcons.notice.rawValue),
                 MyInfo(title: "자주묻는 질문", image: GeneralIcons.faq.rawValue),
                 MyInfo(title: "1:1 문의", image: GeneralIcons.qna.rawValue),
                 MyInfo(title: "알림 설정", image: GeneralIcons.siren.rawValue),
                 MyInfo(title: "이용약관", image: GeneralIcons.permit.rawValue),
        ]
    }
}
