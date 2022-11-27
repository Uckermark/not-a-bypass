//
//  Controller.swift
//  not-a-bypass
//
//  Created by Leonard Lausen on 26.11.22.
//

import Foundation

class Controller: ObservableObject {
    @Published var isWorking = false
    @Published var log = ""
    
    func installDummy() {
        guard let dummy = Bundle.main.path(forResource: "substitute-dummy", ofType: ".deb") else {
            addToLog(msg: "Could not find dummy deb")
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            let ret = spawn(command: "/usr/bin/dpkg", args: ["-i", dummy], root: true)
            spawn(command: "/usr/bin/sbreload", args: [], root: true)
            DispatchQueue.main.async {
                self.addToLog(msg: ret.1)
            }
        }
    }
    
    func installSubstitute() {
        guard let substitute = Bundle.main.path(forResource: "substitute", ofType: ".deb") else {
            addToLog(msg: "Could not find dummy deb")
            return
        }
        
        DispatchQueue.global(qos: .utility).async {
            let ret = spawn(command: "/usr/bin/dpkg", args: ["-i", substitute], root: true)
            spawn(command: "/usr/bin/sbreload", args: [], root: true)
            DispatchQueue.main.async {
                self.addToLog(msg: ret.1)
            }
        }
    }
    
    func addToLog(msg: String) {
        log = log + "\n" + msg
    }
}
