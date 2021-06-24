//
//  StringExtension.swift
//  Chat2chat
//
//  Created by Oleksiy on 13.02.2021.
//

import Foundation

extension String {

    private var length: Int {
        return count
    }

    private func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    private func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
}

extension String {
    static func ~= (lhs: String, rhs: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: rhs) else {
            return false
        }
        return regex.matches(lhs)
    }
}

