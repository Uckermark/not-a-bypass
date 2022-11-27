//
//  ContentView.swift
//  not-a-bypass
//
//  Created by Uckermark on 26.11.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: Controller
    
    var body: some View {
        Text("Not a bypass™")
            .padding()
            .font(.headline)
            .multilineTextAlignment(.center)
        Spacer()
        if controller.isWorking {
            Button("Please wait...", action: { controller.addToLog(msg: "") })
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 0, green: 0.235, blue: 0.49))
                .cornerRadius(10)
                .disabled(true)
        } else if !FileManager().fileExists(atPath: "/var/jb/.no-substitute") {
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
