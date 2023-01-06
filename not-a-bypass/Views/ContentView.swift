//
//  ContentView.swift
//  not-a-bypass
//
//  Created by Uckermark on 26.11.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: Controller
    private let jailbreak: (Tweak_injection, Int, Bool)
    
    init(pController: Controller) {
        controller = pController
        jailbreak = getJB()
    }
    
    var body: some View {
        if jailbreak.2 == true {
            UnsupportedView(reason: "Rootless jailbreaks are not supported.")
        } else if jailbreak.1 < 14 {
            UnsupportedView(reason: "Devices below iOS 14 are supported.")
        } else if jailbreak.0 == .substrate {
            UnsupportedView(reason: "Cydia substrate based jailbreaks are not and will never be supported.")
        } else if jailbreak.0 != .substitute {
            UnsupportedView(reason: "Only substitute based jailbreaks are supported, but Libhooker and Ellekit support will be added.")
        } else {
            BypassView(pController: controller)
        }
    }
}
