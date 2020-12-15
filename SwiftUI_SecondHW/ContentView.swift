//
//  ContentView.swift
//  SwiftUI_SecondHW
//
//  Created by Yevhen Shevchenko on 15.12.2020.
//

import SwiftUI

struct ContentView: View {
    
    @State private var redValue = 154.0
    @State private var greenValue = 14.0
    @State private var blueValue = 63.0
    
    @State private var showAlert = false
    
    private func validation(_ value: inout Double) {
        
        let range = 0.0...255.0
        
        if !range.contains(value) {
            showAlert = true
            value = 0
        }
    }
}

// MARK: - body

extension ContentView {
    
    var body: some View {
        
        VStack {
            CustomeRoundedRectangle(red: redValue, green: greenValue, blue: blueValue)
            
            VStack {
                
                HStack {
                    CustomeText(value: redValue)
                    CustomeSlider(value: $redValue, min: 0, max: 255, step: 1, accentColor: .red)
                    CustomeTextField(value: $redValue, showAlert: $showAlert) { validation(&redValue) }
                    
                }
                
                HStack {
                    CustomeText(value: greenValue)
                    CustomeSlider(value: $greenValue, min: 0, max: 255, step: 1, accentColor: .green)
                    CustomeTextField(value: $greenValue, showAlert: $showAlert) { validation(&greenValue) }
                }
                
                HStack {
                    CustomeText(value: blueValue)
                    CustomeSlider(value: $blueValue, min: 0, max: 255, step: 1, accentColor: .blue)
                    CustomeTextField(value: $blueValue, showAlert: $showAlert) { validation(&blueValue) }
                }
            }
            .padding(.top, 16)
            Spacer()
        }
        .padding()
    }
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - CustomeRoundedRectangle

struct CustomeRoundedRectangle: View {
    
    let red: Double
    let green: Double
    let blue: Double
    
    var height: CGFloat = 200
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(Color(red: red / 255, green: green / 255, blue: blue / 255))
            .frame(height: height)
    }
}

// MARK: - CustomeText

struct CustomeText: View {
    
    let value: Double
    
    var body: some View {
        Text("\(lround(value))")
            .frame(width: 40)
    }
}


// MARK: - CustomeSlider

struct CustomeSlider: View {
    
    @Binding var value: Double
    
    let min: Double
    let max: Double
    let step: Double
    let accentColor: Color
    
    var body: some View {
        Slider(value: $value, in: min...max, step: step)
            .accentColor(accentColor)
    }
}

// MARK: - CustomeTextField

struct CustomeTextField: View {
    
    @Binding var value: Double
    @Binding var showAlert: Bool
    
    var placeholder = ""
    let action: () -> Void
    
    var body: some View {
        TextField(placeholder, value: $value, formatter: NumberFormatter(), onCommit: action)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
            .frame(width: 50)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Wrong format"), message: Text("Please enter value from 0 to 255"))
            }
    }
}


