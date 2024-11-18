//
//  ContentView.swift
//  bonus3
//
//  Created by James.Lai on 17/11/2024.
//


import SwiftUI

struct ContentView: View {
    @State private var baseAmount: String = ""
    @State private var convertedAmount: String = "0.00"
    @State private var isConvertingToTWD: Bool = true
    @State private var exchangeRateSGDtoTWD: Double = 24.17
    @State private var exchangeRateTWDtoSGD: Double = 0.41
    let number : [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0", "back"]
    var body: some View {
        VStack(spacing: 5) {
            ZStack{
                Rectangle()
                    .foregroundColor(.orange)
                    .frame(width: 270,height: 80)
                    .cornerRadius(10)
                Text("Dollar Exchange")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.black)
            }
            
            Text(isConvertingToTWD ? "SGD -> TWD" : "TWD -> SGD")
                .font(.title)
                .padding()
                .foregroundColor(.orange)
            HStack{
                // 顯示輸入的金額
                Text("\(baseAmount) \(isConvertingToTWD ? "SGD:" : "TWD:")")
                    .font(.title)
                    .foregroundColor(.orange)
                    .padding()
                Text("\(convertedAmount) \(isConvertingToTWD ? "TWD" : "SGD")")
                    .font(.title)
                    .foregroundColor(.orange)
                

            }
            // number keyboadr
            VStack(spacing: 10) {
                let columns = Array(repeating: GridItem(), count: 3)
                LazyVGrid(columns: columns) {
                    ForEach(number, id: \.self) { key in
                        Button(action: {
                            handleKeyPress(key)
                        }) {
                            Text(key)
                                .font(.title)
                                .frame(width: 80, height: 80)
                                .background(Color.orange.opacity(1))
                                .cornerRadius(10)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
            .frame(width: 270)
            
            HStack(spacing: 10){
                Button("Switch") {
                    isConvertingToTWD.toggle()
                    baseAmount = ""
                    convertedAmount = "0.00"
                }
                .font(.subheadline)
                .padding()
                .background(Color.orange)
                .foregroundColor(.black)
                .cornerRadius(30)
                .bold()
                
                Button("Calculate") {
                    calculateConversion()
                }
                .bold()
                .padding()
                .background(Color.orange)
                .foregroundColor(.black)
                .cornerRadius(30)
                
                Button("Clear") {//清除資料
                    baseAmount = ""
                    convertedAmount = "0.00"
                }
                .font(.subheadline)
                .padding()
                .background(Color.orange)
                .foregroundColor(.black)
                .cornerRadius(30)
                .bold()
            }
            .padding()
            
            
            
            Spacer()
        }
        .padding()
    }
    
    private func handleKeyPress(_ key: String) {
        switch key {
        case "back":
            if !baseAmount.isEmpty {
                baseAmount.removeLast()
            }
        case ".":
            if !baseAmount.contains(".") {
                baseAmount += key
            }
        default:
            baseAmount += key
        }
    }
    
    private func calculateConversion() {
        if let amount = Double(baseAmount) {
            let result = isConvertingToTWD ? amount * exchangeRateSGDtoTWD : amount * exchangeRateTWDtoSGD
            convertedAmount = String(format: "%.2f", result)
        }
    }
}

#Preview {
    ContentView()
}
