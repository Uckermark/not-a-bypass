//
//  BypassView.swift
//  not-a-bypass
//
//  Created by Uckermark on 04.01.23.
//

import SwiftUI

struct BypassView: View {
    @ObservedObject private var controller: Controller
    let buttonText: String
    private let isBypassed: Bool
    private let deviceInfo: String
    
    init(pController: Controller, device: String) {
        if FileManager().fileExists(atPath: "/.no-substitute") {
            buttonText = "Enable tweaks"
            isBypassed = true
        } else {
            buttonText = "Bypass"
            isBypassed = false
        }
        controller = pController
        deviceInfo = device
    }
    var body: some View {
        VStack {
            Text("Not a bypass™")
                .padding()
                .font(.headline)
            Spacer()
            if controller.isWorking {
                Button("Please wait...") {}
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
                Text(controller.log + "\nPlease send me a screenshot of the error message")
            }
            Spacer()
            Text("by Uckermark\nDiscord: RichardausderUckermark#9083\nTwitter: @uckerm4rk")
                .font(.system(size: 11.0))
                .multilineTextAlignment(.center)
            Text(deviceInfo)
                .font(.system(size: 11.0))
        }
        .alert(isPresented: $controller.respring) {
            Alert(
                title: Text("Respring device?"),
                primaryButton: .destructive(Text("No")),
                secondaryButton: .default(Text("Yes"), action: {
                    spawn(command: "/usr/bin/sbreload", args: [], root: true)
                })
            )
        }
    }
}
