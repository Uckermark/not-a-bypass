//
//  System.swift
//  not-a-bypass
//
//  Created by Leonard Lausen on 06.01.23.
//

import Foundation


public enum Tweak_injection {
    case substitute
    case libhooker
    case substrate
    case ellekit
    case unknown
}

public func getDeviceInfo() -> (Tweak_injection, Int, Bool) {
    let ios_version = ProcessInfo.processInfo.operatingSystemVersion.majorVersion
    var tweak_injection: Tweak_injection = .unknown
    if FileManager().fileExists(atPath: "/var/jb") {
        return (tweak_injection, ios_version, true)
    }
    
    let substitute = spawn(command: "/usr/bin/dpkg-query", args: ["-s", "com.ex.substitute"], root: true).1
    let libhooker = spawn(command: "/usr/bin/dpkg-query", args: ["-s", "org.coolstar.libhooker"], root: true).1
    let substrate = spawn(command: "/usr/bin/dpkg-query", args: ["-s", "mobilesubstrate"], root: true).1
    let ellekit = spawn(command: "/usr/bin/dpkg-query", args: ["-s", "ellekit"], root: true).1
    
    if substitute.contains("install ok installed") {
        tweak_injection = .substitute
    } else if libhooker.contains("install ok installed") && !libhooker.contains("libhooker-shim") {
        tweak_injection = .libhooker
    } else if substrate.contains("install ok installed") {
        tweak_injection = .substrate
    } else if ellekit.contains("install ok installed") {
        tweak_injection = .ellekit
    }
    return (tweak_injection, ios_version, false)
}

public func getInfoString() -> String {
    let data = getDeviceInfo()
    var infoString = ""
    switch data.0 {
    case .substrate:
        infoString.append("Substrate")
    case .substitute:
        infoString.append("Substitute")
    case .ellekit:
        infoString.append("Ellekit")
    case .libhooker:
        infoString.append("Libhooker")
    case .unknown:
        infoString.append("Unknown")
    }
    infoString.append(" on iOS \(data.1)")
    if data.2 {
        infoString.append(" rootless")
    }
    infoString.append("")
    return infoString
}
