//
//  Note.swift
//  
//
//  Created by Alex K on 6/26/19.
//

import Foundation

struct Note {
    let uuid:uuid = UUID().uuidString
    let title: String
    let content: String
    let color: UIColor = UIColor.
    let importance: NoteImportance = .usual
}

enum NoteImportance {
    case notImportant
    case usual
    case important
}

