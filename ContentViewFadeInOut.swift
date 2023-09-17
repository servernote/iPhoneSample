//
//  ContentViewFadeInOut.swift
//  SpecTest
//
//  Created by ServerNote.NET on 2023/09/17.
//

import SwiftUI

struct ContentViewFadeInOut: View {
    @State private var fadeInOut = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear() {
            withAnimation(Animation.easeInOut(duration:0.6)
                .repeatForever(autoreverses: true)) {
                    fadeInOut.toggle()
                }
        }.opacity(fadeInOut ? 0:1)
        .padding()
    }
}
