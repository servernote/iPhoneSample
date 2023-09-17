//
//  ContentViewFadeIn.swift
//  SpecTest
//
//  Created by ServerNote.NET on 2023/09/17.
//

import SwiftUI

struct ContentViewFadeIn: View {
    @State private var fadeInOut = true
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear() {
            withAnimation(Animation.easeIn(duration:5)) {
            //    .repeatForever(autoreverses: true)) {
                    fadeInOut.toggle()
                }
        }.opacity(fadeInOut ? 0:1)
        .padding()
    }
}
