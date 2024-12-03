//
//  Constants.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/6/24.
//

import Foundation

var samplePreference = FacultyPreference(Preop_Communication: .phoneCall, Preop_Assessment: .comprehensivePresentation)

var sampleFaculty = Faculty2(preferences: samplePreference)

let samplePreferences = [
    PreferenceOption(title: "Preoperative Communication", options: ["Phone Call", "Text"]),
    PreferenceOption(title: "Preop Assessment", options: ["Comprehensive Presentation", "Pertinent Positives and Negatives Only"])
]




