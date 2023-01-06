//
//  System.swift
//  not-a-bypass
//
//  Created by Leonard Lausen on 06.01.23.
//

import Foundation
import SwiftUI

public enum Tweak_injection {
    case substitute
    case libhooker
    case substrate
    case ellekit
    case unknown
}

//checks for various files which indicate the installed jb
public func getJB() -> (Tweak_injection, Int, Bool) {
    let ios_version = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
    var tweak_injection: Tweak_injection = .unknown
    if FileManager().fileExists(atPath: "/var/jb") {
        return (.unknown, ios_version, true)
    }
    
    let substitute = spawn(command: "/usr/bin/dpkg-query", args: ["-s", "com.ex.substitute"], root: true).1
    let libhooker = spawn(command: "/usr/bin/dpkg-query", args: ["-s", "org.coolstar.libhooker"], root: true).1
    let substrate = spawn(command: "/usr/bin/dpkg-query", args: ["-s", "mobilesubstrate"], root: true).1
    let ellekit = spawn(command: "/usr/bin/dpkg-query", args: ["-s", " insert ellekit id"], root: true).1
    
    if substitute.contains("installed") {
        tweak_injection = .substitute
    } else if libhooker.contains("installed") && !libhooker.contains("libhooker-shim") {
        tweak_injection = .libhooker
    } else if substrate.contains("installed") {
        tweak_injection = .substrate
    } else if ellekit.contains("installed") {
        tweak_injection = .ellekit
    }
    return (tweak_injection, ios_version, false)
}
