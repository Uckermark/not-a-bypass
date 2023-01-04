//
//  ContentView.swift
//  not-a-bypass
//
//  Created by Uckermark on 26.11.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var controller: Controller
    private let jailbreak: Jailbreak
    
    init(pController: Controller) {
        controller = pController
        jailbreak = getJB()
    }
    
    var body: some View {
        if getJB() == .palera1n_root {
            BypassView(pController: controller)
        } else {
            UnsupportedView()
        }
    }
}
