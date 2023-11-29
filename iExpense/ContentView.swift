//
//  ContentView.swift
//  iExpense
//
//  Created by Adriano Valumin on 10/31/23.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Button("Dismiss") {
            dismiss()
        }
    }
}

struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        VStack {
            Text("Hello :)")

            Button("Show Sheet") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet, content: {
                SecondView()
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
