//
//  Controller.swift
//  not-a-bypass
//
//  Created by Uckermark on 26.11.22.
//

import Foundation

class Controller: ObservableObject {
    @Published var isWorking = false
    @Published var log = ""
    @Published var respring = false
    func installDummy() {
        guard let dummy = Bundle.main.path(forResource: "substitute-dummy", ofType: ".deb") else {
            addToLog(msg: "Could not find dummy deb")
            return
        }
        isWorking = true
        DispatchQueue.global(qos: .utility).async {
            let ret = spawn(command: "/usr/bin/dpkg", args: ["-i", dummy], root: true)
            DispatchQueue.main.async {
                self.addToLog(msg: ret.1)
                self.respring = true
                self.isWorking = false
            }
        }
    }
    
    func installSubstitute() {
        guard let substitute = Bundle.main.path(forResource: "substitute", ofType: ".deb") else {
            addToLog(msg: "Could not find dummy deb")
            return
        }
        isWorking = true
        DispatchQueue.global(qos: .utility).async {
            let ret = spawn(command: "/usr/bin/dpkg", args: ["-i", substitute], root: true)
            DispatchQueue.main.async {
                self.addToLog(msg: ret.1)
                self.respring = true
                self.isWorking = false
            }
        }
    }
    
    func addToLog(msg: String) {
        log = log + "\n" + msg
    }
}
