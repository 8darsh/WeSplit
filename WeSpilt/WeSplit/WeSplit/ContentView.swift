//
//  ContentView.swift
//  WeSplit
//
//  Created by Adarsh Singh on 25/02/23.
//

import SwiftUI
    
struct ContentView: View {
    @State private var amount = 0.0
    @State private var noOfPeople = 2
    @State private var tipPercent = 20
    @FocusState private var amountIsFocused: Bool
//   let tipPercentage = [5,10,20,15,2,0]
let tipPercentage = 0...100
    var totalAmount:Double {
        let peoplecount = Double(noOfPeople + 2)
        let tipSelection = Double(tipPercent)
        let totalPercent = (amount  * tipSelection) / 100
        let amountPer = (totalPercent + amount)
        let amountPerPerson = (amountPer / peoplecount)

        return amountPerPerson
    }
    var newFormat: FloatingPointFormatStyle<Double>.Currency{
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
    }
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Amount", value: $amount, format: newFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("No. of People ", selection: $noOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    
                    Picker("Tip", selection: $tipPercent){
                        ForEach(tipPercentage, id: \.self){
                            Text($0, format: .percent)
                        }
                        
                    }.pickerStyle(.wheel)
                }header: {
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(totalAmount, format: newFormat)
                }header: {
                    Text("Amount per person")
                }
                Section{
                    let totalmount = totalAmount * Double(noOfPeople+2)
                    Text(totalmount, format: newFormat)
                }header: {
                    Text("Total Amount")
                    
                }
            }
                .navigationTitle("WeSplit")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done"){
                            amountIsFocused = false
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
