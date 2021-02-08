//
//  ContentView.swift
//  calculator
//
//  Created by ozan honamlioglu on 7.02.2021.
//

import SwiftUI

struct ButtonTypes: Hashable {
    let label: String
    let value: Int
    let color: Color
    var multiplier: CGFloat = 1
}

class GlobalEnvironment: ObservableObject {
    @Published var display = "0"
    
    func receiveInput(calculatorButton: ButtonTypes) {
        self.display = calculatorButton.label
    }
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    let buttons: [[ButtonTypes]] = [
        [ButtonTypes(label: "AC", value: 16, color: Color(red: 0.7, green: 0.7, blue: 0.7, opacity: 1)), ButtonTypes(label: "+/-", value: 17, color: Color(red: 0.7, green: 0.7, blue: 0.7, opacity: 1)), ButtonTypes(label: "%", value: 18, color: Color(red: 0.7, green: 0.7, blue:  0.7, opacity: 1)), ButtonTypes(label: "/", value: 19, color: .orange)],
        [ButtonTypes(label: "7", value: 7, color: .secondary), ButtonTypes(label: "8", value: 8, color: .secondary), ButtonTypes(label: "9", value: 9, color: .secondary), ButtonTypes(label: "X", value: 14, color: .orange)],
        [ButtonTypes(label: "4", value: 4, color: .secondary), ButtonTypes(label: "5", value: 5, color: .secondary), ButtonTypes(label: "6", value: 6, color: .secondary), ButtonTypes(label: "+", value: 13, color: .orange)],
        [ButtonTypes(label: "1", value: 1, color: .secondary), ButtonTypes(label: "2", value: 2, color: .secondary), ButtonTypes(label: "3", value: 3, color: .secondary), ButtonTypes(label: "-", value: 12, color: .orange)],
        [ButtonTypes(label: "0", value: 0, color: .secondary, multiplier: 2.15), ButtonTypes(label: ".", value: 14, color: .secondary), ButtonTypes(label: "=", value: 11, color: .orange)]
    ]
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 12) {
                
                HStack {
                    Spacer()
                    Text(env.display).font(.system(size: 64)).foregroundColor(.white)
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }

                }
                
            }.padding(.bottom)
        }
        
    }
    
}

struct CalculatorButtonView: View {
    @EnvironmentObject var env: GlobalEnvironment
    var button: ButtonTypes
    
    var body: some View {
        Button(action: {
            self.env.receiveInput(calculatorButton: button)
        }, label: {
            Text(button.label)
                .font(.system(size: 32))
                .frame(width: self.buttonWidth(button.multiplier), height: self.buttonWidth(), alignment: .center)
                .foregroundColor(.white)
        })
        .background(button.color)
        .cornerRadius(self.buttonRadius())
    }
    
    func buttonWidth(_ multiplier: CGFloat = 1) -> CGFloat {
        return ((UIScreen.main.bounds.width - 5 * 12) / 4) * multiplier
    }
    
    func buttonRadius() -> CGFloat {
        return buttonWidth() / 2
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnvironment())
    }
}
