//
//  FacultyMain.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation
import SwiftUI

struct FacultyMain: View {
    
    var body: some View {
        ZStack {
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .offset(x: -30, y: 0)
        }
       
    }
}

#Preview {
    FacultyMain()
}
