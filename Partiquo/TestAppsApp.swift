//
//  TestAppsApp.swift
//  TestApps
//
//  Created by Lourdes Estrada Terres on 19/12/25.
//

import SwiftUI
internal import Combine

class Opperatory: ObservableObject {
    
    @Published var result: Float?
    @Published var num1: Float?
    @Published var new1: Float?
    @Published var num2: Float?
    @Published var new2: Float?
    @Published var Op: String
    @Published var Calculate: Bool
    
    func Calc() {
        
    }
    
    init(result: Float?, num1: Float?, new1: Float?, num2: Float?, new2: Float?, Op: String, Calculate: Bool) {
        self.result = result
        self.num1 = num1
        self.num2 = num2
        self.new1 = new1
        self.new2 = new2
        self.Op = Op
        self.Calculate = Calculate
    }
}

@main
struct TestAppsApp: App {
    var body: some Scene {
        WindowGroup {
            MenuView().environmentObject(Opperatory(result: nil, num1: nil, new1: nil, num2: nil, new2: nil, Op: "?", Calculate: false))
        }
    }
}
