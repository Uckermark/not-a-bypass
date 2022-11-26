//
//  ContentView.swift
//  not-a-bypass
//
//  Created by Uckermark on 26.11.22.
//

import SwiftUI

struct ContentView: View {
    var controller: Controller
    var body: some View {
        Text("Not a bypass™")
            .font(.subheadline)
            .multilineTextAlignment(.center)
        Spacer()
        if !FileManager().fileExists(atPath: "/.dummy") {
            Button("bypass", action: controller.installDummy)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        } else {
            Button("un-bypass", action: controller.installSubstitute)
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
        }
        Text(controller.log)
        Spacer()
    }
}
