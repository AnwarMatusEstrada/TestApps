//
//  HistoryView.swift
//  TestApps
//
//  Created by Lourdes Estrada Terres on 19/12/25.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        let Hdata: String = readFromHist()
        Text(Hdata)
    }
}

#Preview {
    HistoryView()
}
