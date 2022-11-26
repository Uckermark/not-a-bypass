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
        if !FileManager().fileExists(atPath: "/.dummy") {
            Button("bypass", action: controller.installDummy)
        } else {
            Button("un-bypass", action: controller.installSubstitute)
        }
        Text(controller.log)
    }
}
