//
//  FileNotebook.swift
//  
//
//  Created by Alex K on 6/29/19.
//

import Foundation
import UIKit

let parseNote = Note.parse

class FileNotebook {
    
    var notes:[String: Note] = [:]
    
    var Note: [String: Note] {
        get {
            return self.notes
        }
    }
    
    public func add(_ note: Note) {
        
        self.notes[note.uuid] = note
    }
    public func remove(with uid: String) {
        self.notes[uid] = nil
    }
    
    public func saveToFile() {
        let jsonRepr = self.notes.map { (key, note) in
            note.json
        }
        do {
            guard let path = FileManager.default.urls(for: .cachesDirectory,
                                                      in: .userDomainMask).first else {
                print("cannot retrieve path")
                return
            }
            let jsonNotebookPath = path.appendingPathComponent("notebook.json")
            guard let stream = OutputStream(toFileAtPath: jsonNotebookPath.path , append: false) else {
                print("cannot open file")
                return
            }
            print("before write")
            
            stream.open()
            defer {
                stream.close()
            }
            var error: NSError?
            JSONSerialization.writeJSONObject(jsonRepr, to: stream, error: &error)
            stream.close()
            print("after write")
            if let error = error {
                print("error when writing file: \(error)")
            }
        }
        catch {
            print("error when saving: \(error)")
        }
    }
    
    public func loadFromFile() {
        guard let path = FileManager.default.urls(for: .cachesDirectory,
                                                  in: .userDomainMask).first else {
                                                    return
        }
        let jsonNotebookPath = path.appendingPathComponent("notebook.json")
        
        guard let stream = InputStream(fileAtPath: jsonNotebookPath.path) else {
            return
        }
        stream.open()
        defer {
            stream.close()
        }
        do {
            let res = try JSONSerialization.jsonObject(with: stream, options: [])
            guard let arr = res as? [[String:Any]] else {
                return
            }
            arr.forEach { noteJSON in
                guard let note = parseNote(noteJSON) else {
                    print("Cannot parse note")
                    return
                }
                self.add(note)
            }
        }
        catch {
            print("error: \(error)")
        }
    }
}
