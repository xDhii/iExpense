//
//  ContentView.swift
//  iExpense
//
//  Created by Adriano Valumin on 10/31/23.
//

import SwiftUI

struct User: Codable {
    let firstName: String
    let lastName: String
}

struct CodableView: View {
    @State private var user = User(firstName: "Adriano", lastName: "Valumin")

    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()

            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct UserDefault: View {
    @AppStorage("tapCount") private var tapCount = 0
    var body: some View {
        Button("Tap Count: \(tapCount)") {
            tapCount += 1
        }
        Divider()
        Button("Reset") {
            tapCount = 0
        }
    }
}

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
    @State private var showingOnDelete = false
    @State private var showingUserDefaults = false
    @State private var showingCodable = false
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        List {
            Button("Show onDelete") {
                showingOnDelete.toggle()
            }
            .sheet(isPresented: $showingOnDelete, content: {
                OnDelete()
            })

            Button("Show UserDefaults") {
                showingUserDefaults.toggle()
            }
            .sheet(isPresented: $showingUserDefaults, content: {
                UserDefault()
            })
            
            Button("Show Codable") {
                showingCodable.toggle()
            }
            .sheet(isPresented: $showingCodable, content: {
                CodableView()
            })
        }
    }
}

#Preview {
    ContentView()
}
