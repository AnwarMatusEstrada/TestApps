//
//  MenuArchView.swift
//  TestApps
//
//  Created by Lourdes Estrada Terres on 23/12/25.
//

import SwiftUI
import Foundation

struct MenuArchView: View {
    
    @Binding var fn: String
    @Binding var maxread: Int
    let Dir: String = URL.documentsDirectory.path
    
    @State var cont: [String] = []
    
    func getDir(c: String) {
        fn = c
    }
    
    var body: some View {
        VStack{
            NavigationStack{
                ForEach(cont, id: \.self) { c in
                    Button("\(c)"){
                        getDir(c: c)
                    }.tag(c)
                }
                NavigationLink(destination: MapView(fn: $fn, maxread: $maxread)){
                    Text("Go to map").padding(30)
                }
            }
        }.onAppear {
            do{
                cont = try FileManager.default.contentsOfDirectory(atPath: "\(Dir)")
            } catch {
                print("Not Read for \(Dir): \(error)")
            }
        }
    }
}
