//
//  ContentViewButtons.swift
//  MyUITest
//
//  Created by ServerNote.NET on 2023/09/18.
//

import SwiftUI

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255,
            opacity: alpha
        )
    }
}

class G: ObservableObject {
    
    static var shared = G()
    
    @Published var screen_button_width:CGFloat
    @Published var screen_button_height:CGFloat
    
    init() {
        var w = UIScreen.main.bounds.width < UIScreen.main.bounds.height ?
        UIScreen.main.bounds.width:UIScreen.main.bounds.height
        screen_button_width = w / 3 * 2
        screen_button_height = 60
        if screen_button_width > 400 {
            screen_button_width = 400
        }
    }
}

struct ContentViewButtons: View {
    @State private var showButtons = false
    
    var body: some View {
        VStack {
            Button(action: {
                print("Button1 pressed")
                withAnimation {
                    showButtons = true
                }
                
            }) {
                Text("ボタンを右から出現させます")
                    .bold()
                    .padding()
                    .frame(width: G.shared.screen_button_width, height: G.shared.screen_button_height)
                    .foregroundColor(Color.white)
                    .background(
                        LinearGradient(
                            colors: [Color(0xFD79A8), Color(0xFFB5A3)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .cornerRadius(10)
            }
            if showButtons {
                Button(action: {
                    print("Button2 pressed")
                    withAnimation {
                        showButtons = false
                    }
                }) {
                    Text("このボタンを右へ消します")
                        .bold()
                        .padding()
                        .frame(width: G.shared.screen_button_width, height: G.shared.screen_button_height)
                        .foregroundColor(Color(0x969696))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(0x969696), lineWidth: 3)
                        )
                }
                .transition(.move(edge: .trailing))
            }
        }
    }
}

struct ContentViewButtons_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewButtons()
    }
}
