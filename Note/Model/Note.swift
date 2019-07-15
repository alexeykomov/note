//
//  Note.swift
//
//
//  Created by Alex K on 6/26/19.
//

import Foundation
import UIKit

struct Note: Equatable {
    init(uuid: String = UUID().uuidString,
         title: String,
         content: String,
         color: UIColor = .white,
         importance: NoteImportance,
         selfDestructionDate: Date = Date(timeIntervalSince1970: 0)) {
        self.uuid = uuid
        self.title = title
        self.content = content
        self.color = color
        self.importance = importance
        self.selfDestructionDate = selfDestructionDate
    }
    
    let uuid:String
    let title: String
    let content: String
    let color: UIColor
    let importance: NoteImportance
    let selfDestructionDate: Date
}

enum NoteImportance: String {
    case notImportant = "notImportant"
    case usual = "usual"
    case important = "important"
}

