//
//  ContentView.swift
//  not-a-bypass
//
//  Created by Uckermark on 26.11.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: Controller
    let buttonText: String
    private let isBypassed: Bool
    
    init(pController: Controller) {
        if FileManager().fileExists(atPath: "/.no-substitute") {
            buttonText = "Enable tweaks"
            isBypassed = true
        } else {
            buttonText = "Bypass"
            isBypassed = false
        }
        controller = pController
    }
    
    var body: some View {
        VStack {
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
            } else {
                Button(buttonText, action: { controller.install(bypass: !isBypassed) } )
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            if controller.log != "" {
                Text(controller.log)
            }
            Spacer()
        }
        .alert("The device will now respring", isPresented: $controller.respring) {
            Button("OK", role: .cancel) {
                spawn(command: "/usr/bin/sbreload", args: [], root: true)
            }
        }
    }
}
