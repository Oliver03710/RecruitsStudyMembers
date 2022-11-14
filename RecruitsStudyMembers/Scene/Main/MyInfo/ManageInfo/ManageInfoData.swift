//
//  ManageInfoData.swift
//  RecruitsStudyMembers
//
//  Created by Junhee Yoon on 2022/11/14.
//

import Foundation

import RxDataSources

protocol PresentMenuSectionItem {

}

struct ImageItem {
    
}

struct FoldableItem {
    
}

struct RestItem {
    
}

enum PresentMenuSectionModel {
    case SectionImage(items: [ImageItem])
    case SectionFoldable(header: String, items: [FoldableItem])
    case SectionRest(items: [RestItem])
}

extension PresentMenuSectionModel: SectionModelType {
    typealias Item = PresentMenuSectionItem

    init(original: PresentMenuSectionModel, items: [PresentMenuSectionItem]) {
        self = original
    }

    var headers: String? {
        if case let .SectionMenu(header, _, _) = self {
            return header
        }
        return nil
    }

    var selectType: SelectType? {
        if case let .SectionMenu(_, type, _) = self {
            return type
        }
        return nil
    }

  var items: [Item] {
      switch self {
      case let .SectionMainTitle(items):
          return items
      case let .SectionMenu(_, _, items):
          return items
      case let .SectionSelectCount(items):
          return items
      }
  }
}

struct CustomData {
    var name: String
    var age: Int
    var country: String
}

struct SectionOfCustomData {
    var header: String?
    var footer: String?
    var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
  typealias Item = CustomData

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}
