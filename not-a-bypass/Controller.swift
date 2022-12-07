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
    
    func install(bypass: Bool) {
        //get .debs
        guard let dummy = Bundle.main.path(forResource: "substitute-dummy", ofType: ".deb"),
            let substitute = Bundle.main.path(forResource: "substitute", ofType: ".deb") else {
            addToLog(msg: "Could not find debs")
            return
        }
        isWorking = true
        
        //check if we want to bypass or reinstall substitute
        let deb: String
        if bypass {
            deb = dummy
        } else {
            deb = substitute
        }
        
        //install selected deb
        DispatchQueue.global(qos: .utility).async {
            let ret = spawn(command: "/usr/bin/dpkg", args: ["-i", deb], root: true) //install deb
            DispatchQueue.main.async {
                if ret.0 == 0 {
                    self.respring = true //show respring dialogue if successful
                } else {
                    self.addToLog(msg: ret.1) //else save install logs
                }
                self.isWorking = false
            }
        }
    }
    
    func addToLog(msg: String) {
        log = log + "\n" + msg
    }
}
