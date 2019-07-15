//
//  NoteTests.swift
//  NoteTests
//
//  Created by Alex K on 7/2/19.
//

import XCTest
@testable import Note

class NoteTests: XCTestCase {
    var formatter:DateFormatter = DateFormatter()
    var date:Date = Date()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        guard let date = formatter.date(from: "2019-07-15T09:31:51.000Z") else {
            return XCTFail("cannot parse date")
            
        }
        self.date = date
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStringify1() {
        let noteOrig = Note(uuid: "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                            title: "testNoteTitle1",
                            content: "testNoteContent1",
                            color: UIColor.red, importance: .usual,
                            selfDestructionDate: date).json as! [String:String]
         let noteJSON = ["content": "testNoteContent1",
                         "selfDestructionDate": "2019-07-15T09:31:51.000Z",
                         "uuid": "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                         "title": "testNoteTitle1",
                         "color": "rgba(1.0,0.0,0.0,1.0)"]
        XCTAssert(noteOrig == noteJSON)
    }
    
    func testStringify2() {
        let noteOrig = Note(uuid: "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                            title: "testNoteTitle1",
                            content: "testNoteContent1",
                            color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0),
                            importance: .important,
                            selfDestructionDate: date).json as! [String:String]
        let noteJSON = ["content": "testNoteContent1",
                        "selfDestructionDate": "2019-07-15T09:31:51.000Z",
                        "uuid": "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                        "title": "testNoteTitle1",
                        "importance": "important",
                        "color": "rgba(0.5,0.5,0.5,0.0)"]
        XCTAssert(noteOrig == noteJSON)
    }
    
    func testStringify3() {
        let noteOrig = Note(uuid: "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                            title: "testNoteTitle1",
                            content: "testNoteContent1",
                            color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0),
                            importance: .notImportant,
                            selfDestructionDate: date).json as! [String:String]
        let noteJSON = ["content": "testNoteContent1",
                        "selfDestructionDate": "2019-07-15T09:31:51.000Z",
                        "uuid": "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                        "title": "testNoteTitle1",
                        "importance": "notImportant",
                        "color": "rgba(0.5,0.5,0.5,0.0)"]
        XCTAssert(noteOrig == noteJSON)
    }

    func testParse1() {
        let noteJSON = ["content": "testNoteContent1",
         "selfDestructionDate": "2019-07-15T09:31:51.000Z",
         "uuid": "4B41D4A8-0288-45BC-B378-8BBA863634EE",
         "title": "testNoteTitle1",
         "importance": "notImportant",
         "color": "rgba(0.5,0.5,0.5,0.0)"]
        let noteOrig = Note(uuid: "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                            title: "testNoteTitle1",
                            content: "testNoteContent1",
                            color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0),
                            importance: .notImportant,
                            selfDestructionDate: date)
        guard let noteParsed = Note.parse(json: noteJSON) else {
            return XCTFail("cannot parse Note")
        }
        XCTAssert(noteParsed == noteOrig)
    }
    
    func testParse2() {
        let noteJSON = ["content": "testNoteContent1",
                        "selfDestructionDate": "2019-07-15T09:31:51.000Z",
                        "uuid": "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                        "title": "testNoteTitle1",
                        "color": "rgba(0.5,0.5,0.5,0.0)"]
        let noteOrig = Note(uuid: "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                            title: "testNoteTitle1",
                            content: "testNoteContent1",
                            color: UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0),
                            importance: .usual,
                            selfDestructionDate: date)
        guard let noteParsed = Note.parse(json: noteJSON) else {
            return XCTFail("cannot parse Note")
        }
        XCTAssert(noteParsed == noteOrig)
    }
    
    func testParse3() {
        let noteJSON = ["content": "testNoteContent1",
                        "selfDestructionDate": "2019-07-15T09:31:51.000Z",
                        "uuid": "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                        "title": "testNoteTitle1",
                        "importance": "notImportant",
                        "color": "rgba(1.0,0.0,0.0,1.0)"]
        let noteOrig = Note(uuid: "4B41D4A8-0288-45BC-B378-8BBA863634EE",
                            title: "testNoteTitle1",
                            content: "testNoteContent1",
                            color: UIColor.red,
                            importance: .notImportant,
                            selfDestructionDate: date)
        guard let noteParsed = Note.parse(json: noteJSON) else {
            return XCTFail("cannot parse Note")
        }
        XCTAssert(noteParsed == noteOrig)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
