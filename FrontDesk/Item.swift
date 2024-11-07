//
//  Item.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 10/24/24.
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
