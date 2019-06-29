//
//  FileNotebook.swift
//  
//
//  Created by Alex K on 6/29/19.
//

import Foundation
import Note
import UIKit

class FileNotebok {
    private notes = [String: Note]()
    
    var Note: [String: Note] {
        return notes
    }
    
    public func add(_ note: Note) {
        notes[note.uid] = note
    }
    public func remove(with uid: String) {
        notes[uid] = nil
    }
    
    public func saveToFile() {
        let jsonRepr = notes.map { note in
            note.json
        }
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonRepr, options: [])
            let path = FileManager.default.
        } catch {
            
        }
    }
    
    public func loadFromFile() {
        
    }
}
