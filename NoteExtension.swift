import Foundation
import UIKit

func parseColor(colorString: String) -> UIColor? {
    do {
        guard let regexp = try? NSRegularExpression(pattern: #"[\d\.]+"#) else {
            return nil
        }
        let res = regexp.matches(in: colorString,
                                 range: NSRange(colorString.startIndex..., in: colorString))
        guard res.count == 4 else {
            return nil
        }
        
        let nf = NumberFormatter()
        nf.maximumFractionDigits = 4
        
        var buff = res.map { (n: NSTextCheckingResult) -> CGFloat? in
            guard let floatVal = nf.number(from: String(colorString[Range(n.range, in: colorString)!])) else {
                return nil
            }
            return CGFloat(truncating: floatVal)
        }
        guard let r = buff[0], let g = buff[1], let b = buff[2], let a = buff[3] else {
            return nil
        }
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
    catch {
        print(error)
        return nil
    }
}

func getColor(_ json: [String:Any]) -> UIColor {
    guard let colorString = json["color"] as? String else {
        return .white
    }
    guard let color = parseColor(colorString: colorString) else {
        return .white
    }
    return color
}

func getImportance(_ json: [String:Any]) -> NoteImportance {
    guard let importanceString = json["importance"] as? String else {
        return .usual
    }
    guard let importance = NoteImportance(rawValue: importanceString) else {
        return .usual
    }
    return importance
}

let formatter = DateFormatter()
formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
formatter.timeZone = TimeZone(secondsFromGMT: 0)
formatter.locale = Locale(identifier: "en_US_POSIX")

func getDate(_ json: [String:Any]) -> Date {
    guard let selfDestructionDateString = json["selfDestructionDate"] as? String else {
        return Date(timeIntervalSince1970: 0)
    }
    guard let selfDestructoinDate = formatter.date(from: selfDestructionDateString) else {
        return Date(timeIntervalSince1970: 0)
    }
    return selfDestructoinDate
}

extension Note {
    static func parse(json: [String: Any]) -> Note? {
        guard
            let uuid = json["uuid"] as? String,
            let title = json["title"] as? String,
            let content = json["content"] as? String else {
                return nil
        }
        
        return Note(uuid: uuid,
                    title: title,
                    content: content,
                    color: getColor(json),
                    importance: getImportance(json),
                    selfDestructionDate: getDate(json))
    }
    
    var json: [String: Any] {
        var json = [String: Any]()
        
        json["uuid"] = self.uuid
        json["title"] = self.title
        json["content"] = self.content
        
        if self.color != UIColor.white {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            self.color.getRed(&r, green: &g, blue: &b, alpha: &a)
            json["color"] = "rgba(\(r),\(g),\(b),\(a))"
        }
        
        if self.importance != .usual {
            json["importance"] = self.importance.rawValue
        }
        
        json["selfDestructionDate"] = formatter.string(from: self.selfDestructionDate)
        
        return json
    }
}
