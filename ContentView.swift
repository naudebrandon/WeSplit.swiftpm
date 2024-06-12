import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        //Calculate the total per person here
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        VStack {            
            NavigationStack{
                Form{
                    Section {
                        TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                        
                        Picker("Number of People", selection: $numberOfPeople){
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    Section ("How much tip do you want to leave?") {
                        Picker("Tip percentage", selection: $tipPercentage) {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    
                    Section ("Amount per Person"){
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD") )
                    }
                    
                    Section ("Total Amount"){
                        let totalAmount = totalPerPerson * Double(numberOfPeople + 2)
                        
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                .navigationTitle("We Split")
                .toolbar {
                    if amountIsFocused {
                        Button("Done") {
                            amountIsFocused = false
                        }
                    }
                }
            }
        }
    }
}

#Preview{
    ContentView()
}
