//
//  ContentViewFadeOut.swift
//  MyUITest
//
//  Created by ServerNote.NET on 2023/09/18.
//

import SwiftUI

struct ContentViewFadeOut: View {
    @State private var fadeInOut = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear() {
            withAnimation(Animation.easeOut(duration:2)) {
            //    .repeatForever(autoreverses: true)) {
                    fadeInOut.toggle()
                }
        }.opacity(fadeInOut ? 0:1)
        .padding()
    }
}

struct ContentViewFadeOut_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewFadeOut()
    }
}
