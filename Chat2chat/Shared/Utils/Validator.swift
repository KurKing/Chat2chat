//
//  Validator.swift
//  Chat2chat
//
//  Created by Oleksiy on 20.04.2021.
//

import Foundation

struct Validator {
    func validate(string: String?) -> String? {
        guard var string = string else { return nil }
        string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if string.isEmpty { return nil }
        return string
    }
}
