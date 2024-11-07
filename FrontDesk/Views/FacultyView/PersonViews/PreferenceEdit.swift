//
//  PreferenceEdit.swift
//  FrontDesk
//
//  Created by Zhouyi Jiang on 11/5/24.
//

import Foundation
import SwiftUI

struct PreferenceEdit: View {
//    @StateObject var preferences = samplePreference // use samplePreferences (in constants)
    @State private var selectedOptions: [String: String] = [:]
    
    let buttonSize: CGFloat = 250
    
    
    var body: some View {
        VStack {
            Text("Faculty Preferences")
                .font(.largeTitle)
                .fontWeight(.bold)
//                .padding(.top)
        
            
            

            
            Button(action: savePreferences) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            .padding(.horizontal)
            .padding(.bottom)
        }
    }
    
    
    
    func savePreferences() {
//        print("Selected Preferences: \(selectedPreferences)")
    }

}

struct PreferenceBlock: View {
    let title: String
    let options: [String]
    @State var selectedOption: String
    
    var shouldVstack: Bool {
        options.count > 3 || options.contains{ $0.count > 3 }
    }
    
    
    var body: some View {
        VStack {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
            
            //preferenceOptions subview
            if shouldVstack {
                
            } else {
                
            }
            
            
            
        }
    }
    
    private func PreferenceButton(option: String) -> some View {
        Button(action: {
            selectedOption = option
            
        }){
            Text(title)
                .font(.body)
                .foregroundColor(.white)
                .frame(width: size)
                .padding()
                .background(isSelected ? Color.blue : Color.gray)
                .cornerRadius(10)
//                .onTapGesture {
//                    action()
//                }
        }

    
}

// self-define the preference buttons (Using "onTapGesture")
struct PreferenceOptions: View {
    var title: String
    var isSelected: Bool
    let size: CGFloat
    let action: () -> Void
    
    let options: [String]
    @State var selectedOption: Int?
    
//    @State var selected: [String]
    
    var shouldVstack: Bool {
        options.count > 3 || options.contains{ $0.count > 3 }
    }
    
    
    
    var body: some View {
        Group {
            if shouldVstack {
                VStack {
                    ForEach(options.indices, id: \.self) { index in
                        PreferenceButton(for: index)
                    }
                }
                
            } else {
                HStack {
                    ForEach(options.indices, id: \.self) { index in
                        PreferenceButton(for: index)
                    }
                }
            }
        }
    }
    
    
    private func PreferenceButton(for index: Int) -> some View {
        Button(action: {
            if(selectedOption == index){
                selectedOption = nil
            } else {
                selectedOption = index
            }
        }){
            Text(title)
                .font(.body)
                .foregroundColor(.white)
                .frame(width: size)
                .padding()
                .background(isSelected ? Color.blue : Color.gray)
                .cornerRadius(10)
//                .onTapGesture {
//                    action()
//                }
        }
        
    }
}

#Preview{
    PreferenceEdit()
}
