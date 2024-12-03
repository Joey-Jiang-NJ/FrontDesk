//
//  Item.swift
//  FrontDesk
//
//  Created by DJY on 11/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
