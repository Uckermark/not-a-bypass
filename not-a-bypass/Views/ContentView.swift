//
//  ContentView.swift
//  not-a-bypass
//
//  Created by Uckermark on 26.11.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: Controller
    private let deviceInfo: (Tweak_injection, Int, Bool)
    private let infoString: String
    
    init(pController: Controller) {
        controller = pController
        deviceInfo = getDeviceInfo()
        infoString = getInfoString()
    }
    
    var body: some View {
        if deviceInfo.2 == true {
            UnsupportedView(reason: "Rootless jailbreaks are not supported yet.", device: "\(infoString)")
        } else if deviceInfo.1 < 14 {
            UnsupportedView(reason: "Devices below iOS 14 are not supported yet.", device: "\(infoString)")
        } else if deviceInfo.0 == .substrate {
            UnsupportedView(reason: "Cydia substrate based jailbreaks are not and will never be supported.", device: "\(infoString)")
        } else if deviceInfo.0 != .substitute {
            UnsupportedView(reason: "Only substitute based jailbreaks are supported, but Libhooker and Ellekit support will be added.", device: "\(infoString)")
        } else {
            BypassView(pController: controller, device: "\(infoString)")
        }
    }
}
