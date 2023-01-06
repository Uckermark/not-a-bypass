//
//  UnsupportedView.swift
//  not-a-bypass
//
//  Created by Leonard Lausen on 04.01.23.
//

import SwiftUI

struct UnsupportedView: View {
    @State var alert = true
    @State var reason = ""
    
    var body: some View {
        VStack {
            Text("Not a bypass™")
                .padding()
                .font(.headline)
                .multilineTextAlignment(.center)
            Spacer()
            Button("Unsupported") {}
                .padding()
                .foregroundColor(.white)
                .background(Color(red: 0, green: 0.235, blue: 0.49))
                .cornerRadius(10)
                .disabled(true)
            Spacer()
            if reason == "" {
                Text("Your device is currently unsupported\nYou can contact me to add support")
                    .multilineTextAlignment(.center)
            } else {
                Text(reason)
            }
            Text("Discord: RichardausderUckermark#9083\nTwitter: @uckerm4rk")
        }
        .alert("The device is not supported", isPresented: $alert) {
            Button("OK", role: .cancel) {}
        }
    }
}
