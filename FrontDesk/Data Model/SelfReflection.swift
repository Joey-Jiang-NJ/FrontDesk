//
//  SelfReflection.swift
//  FrontDesk
//
//  Created by Martin Zuo on 12/5/24.
//

import Foundation

struct SelfReflection: Codable {
    var indication: String = ""
    var reviewed: Bool? = nil
    var facultyFeedback: [String] = ["", ""]
    var learnerFeedback: [String] = ["", ""]
    var keySteps: [String] = ["Step 1", "Step 2", "Step 3"]
    var editingIndex: Int? = nil
    var editedText: String = ""
    var selectedProcedureLevel: String? = nil // Track selected procedure level
}
