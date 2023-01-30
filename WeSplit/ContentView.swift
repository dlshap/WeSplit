//
//  ContentView.swift
//  WeSplit
//
//  Created by David Shapiro on 1/30/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    var tipPercentages: [Int] {
        var tipArray = Array<Int>()
        for i in stride(from: 0, to: 100, by: 5) {
            tipArray.append(i)
        }
        return tipArray
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return checkAmount + tipValue
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        return grandTotal / peopleCount
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Check amount")
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 100, id: \.self) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0) %")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Grand total")
                            Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        Spacer()
                        HStack {
                            Text("Per person")
                            Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        .font(.title3)
                        .fontWeight(.bold)
                    }
                } header: {
                    Text("Totals")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
