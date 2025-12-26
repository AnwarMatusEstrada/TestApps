//
//  CalcView.swift
//  TestApps
//
//  Created by Lourdes Estrada Terres on 19/12/25.
//

import SwiftUI
import Foundation

struct CalcView: View {
    
 //   init(){
 //       UINavigationBar.appearance().titleTextAttributes = //[.foregroundColor: UIColor.calcLetra]
    //}
    @EnvironmentObject private var CALC: Opperatory
    
    var body: some View {
        VStack{
            readHist()
            EntryNums()
            Operators()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.calcFondo)
            //.navigationTitle(Text("Calculadora"))
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Calculadora").foregroundColor(Color.calcLetra)
                }
            }
    }
}

struct PutText: View {
    var Texto: String
    var body: some View {
        Text(Texto).foregroundColor(Color.calcLetra)
            .padding(10)
    }
}

func DocDir() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    print(paths)
    return paths[0]
}

struct EntryNums: View {
    @EnvironmentObject private var CALC: Opperatory
    var body: some View {
        NavigationStack {
            PutText(Texto: "Seleccione dos números a operar")
            HStack{
                TextField("Num1", value: $CALC.num1, format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .padding(10)
                    .background(.green.opacity(0.3))
                    .cornerRadius(5)
                    .onChange(of: CALC.num1) { oldValue, newValue in CALC.new1 = newValue
                    }
                    .foregroundColor(Color.calcLetra)
                    .frame(maxWidth: .greatestFiniteMagnitude, maxHeight: 20).padding(10)
                TextField("Num2", value: $CALC.num2, format: .number)
                    .keyboardType(.numbersAndPunctuation)
                    .padding(10)
                    .background(.green.opacity(0.3))
                    .cornerRadius(5)
                    .onChange(of: CALC.num2) { oldValue, newValue in
                        CALC.new2 = newValue
                    }
                    .foregroundColor(Color.calcLetra)
                    .frame(maxWidth:.greatestFiniteMagnitude, maxHeight: 20).padding(10)
            }.frame(maxWidth: .greatestFiniteMagnitude, maxHeight: 20).padding(10)
        }
    }
}

struct Operators: View {
    @EnvironmentObject private var CALC: Opperatory
    
    var body: some View {
        PutText(Texto: "Seleccione la operación")
        HStack{
            Button("+"){
                if (CALC.new1 != nil) && (CALC.new2 != nil){
                    CALC.Op = "+"
                    CALC.result = (CALC.new1 ?? 0.0) + (CALC.new2 ?? 0.0)
                }
            }.frame(maxWidth: .infinity, maxHeight: 80)
                .padding(10).font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.calcOp)
            
            Button("-"){
                if (CALC.new1 != nil) && (CALC.new2 != nil){
                    CALC.Op = "-"
                    CALC.result = (CALC.new1 ?? 0.0) - (CALC.new2 ?? 0.0)
                }
            }.frame(maxWidth: .infinity, maxHeight: 80)
                .padding(10).font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.calcOp)
            
            Button("X"){
                if (CALC.new1 != nil) && (CALC.new2 != nil){
                    CALC.Op = "X"
                    CALC.result = (CALC.new1 ?? 0.0) * (CALC.new2 ?? 0.0)
                }
            }.frame(maxWidth: .infinity, maxHeight: 80)
                .padding(10).font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.calcOp)
            
            Button("/"){
                if (CALC.new1 != nil) && (CALC.new2 != nil){
                    CALC.Op = "/"
                    CALC.result = (CALC.new1 ?? 0.0) / (CALC.new2 ?? 0.0)
                }
            }.frame(maxWidth: .infinity, maxHeight: 80)
                .padding(10).font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.calcOp)
        }
        PrintResult()
    }
}

func writeToHist(msg: Data) -> Bool{
    let Dir: URL = DocDir()
    let file: URL = Dir.appendingPathComponent("Historial.txt")
    do {
        let fileHandle = try FileHandle(forWritingTo: file)
        defer {
            fileHandle.closeFile()
        }
        fileHandle.seekToEndOfFile()
        try fileHandle.write(contentsOf: msg)
        return true
    } catch {
        print("Not written to file")
        return false
    }
    
}

func readFromHist() -> String{
    let Dir: URL = DocDir()
    let file: URL = Dir.appendingPathComponent("Historial.txt")
    var text: String = ""
    
    do {
        text = try String(contentsOf: file, encoding: .utf8)
        let arr: Array = text.split(separator: "\n", omittingEmptySubsequences: true)
        let Arr = arr.suffix(20)
        return Arr.joined(separator: "\n")
    } catch {
        print("Not read from file")
        return "Not"
    }
}

struct PrintResult: View {
    @EnvironmentObject private var CALC: Opperatory
    
    var body: some View {
        if (CALC.new1 != nil) && (CALC.new2 != nil) && (CALC.Op != "?") && (CALC.result != nil){
            let Texto: String = "\(String(CALC.new1 ?? 0.0)) \(CALC.Op) \(String(CALC.new2 ?? 0.0)) = \(String(CALC.result ?? 0.0))\n"
            PutText(Texto: Texto)
            let msgD: Data = Texto.data(using: .utf8)!
            let esc :Bool = writeToHist(msg: msgD)
            if !esc {
                PutText(Texto: " No escrito")
            }
        }
    }
}

struct readHist: View {
    
    var body: some View {
        NavigationStack {
            NavigationLink(destination: HistoryView()){
                PutText(Texto: "Ver Historial")
            }
        }
    }
}

#Preview {
    CalcView()
}
