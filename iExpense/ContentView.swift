//
//  ContentView.swift
//  iExpense
//
//  Created by Adriano Valumin on 10/31/23.
//

import SwiftUI

struct OnDelete: View {
    @Environment(\.dismiss) var dismiss
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(numbers, id: \.self) {
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                }
            }
            .toolbar {
                EditButton()
            }
        }

        Button("Add Number") {
            numbers.append(currentNumber)
            currentNumber += 1
        }
    }

    func removeRows(at offsets: IndexSet) {
        numbers.remove(atOffsets: offsets)
    }
}

struct ContentView: View {
    @State private var showingSheet = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        VStack {
            Button("Show onDelete") {
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet, content: {
                OnDelete()
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
