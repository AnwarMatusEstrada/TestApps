    //
//  ContentView.swift
//  TestApps
//
//  Created by Lourdes Estrada Terres on 19/12/25.
//

import SwiftUI

struct ContentView: View {
    @State var valor: Double = 0.0
    @State var testSTR = ""
    @State var new = ""
    var body: some View {
        VStack {
            Form{
                TextField("Escribe un número", text: $testSTR).keyboardType(.decimalPad)
                    .padding(10)
                    .background(.green.opacity(0.3))
                    .cornerRadius(5)
                    .onChange(of: testSTR) { oldValue, newValue in
                        print(newValue)
                        new = newValue
                    }.submitScope()
            }.onSubmit {
                        valor = Double(new)!
                    }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Valor = \(valor)"){
                valor += 1
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
