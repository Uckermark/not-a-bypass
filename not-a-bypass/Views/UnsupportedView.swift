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
    @State var device = ""
    
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
            Text(reason + "\n" + device + "\n\nGet support:\nDiscord: RichardausderUckermark#9083\nTwitter: @uckerm4rk")
                .font(.system(size: 14.0))
                .multilineTextAlignment(.center)
        }
        .alert(isPresented: $alert) {
            Alert(
                title: Text("This device is unsupported"),
                message: Text(reason),
                dismissButton: .cancel(Text("OK"))
            )
        }
    }
}
