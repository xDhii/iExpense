//
//  ContentView.swift
//  iExpense
//
//  Created by Adriano Valumin on 10/31/23.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let enconded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(enconded, forKey: "Items")
            }
        }
    }

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }

        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false

    private let userCurrency = Locale.current.currency?.identifier ?? "USD"

    var body: some View {
        NavigationStack {
            List {
                Section("Personal") {
                    ForEach(expenses.items) { item in
                        if item.type == "Personal" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)

                                    Text(item.type)
                                }

                                Spacer()

                                Text(item.amount, format: .currency(code: userCurrency))
                                    .foregroundStyle(colorForAmount(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }

                Section("Business") {
                    ForEach(expenses.items) { item in
                        if item.type == "Business" {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)

                                    Text(item.type)
                                }

                                Spacer()

                                Text(item.amount, format: .currency(code: userCurrency))
                                    .foregroundStyle(colorForAmount(item.amount))
                            }
                        }
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense, content: {
                AddView(expenses: expenses)
            })
        }
    }

    private func colorForAmount(_ amount: Double) -> Color {
        switch amount {
        case ..<10:
            return .green
        case 10 ..< 100:
            return .blue
        default:
            return .red
        }
    }

    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
