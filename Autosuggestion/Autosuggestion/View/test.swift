//
//  test.swift
//  Autosuggestion
//
//  Created by 김지민 on 2023/07/14.
//

import Foundation
import AVFoundation



struct test {
    let session = AVAudioSession.sharedInstance()

    func a() {
        
        do{
            try session.setCategory(.playAndRecord, mode: .default)
            try session.setActive(true)
            session.requestRecordPermission { granted in
                print(granted)
            }
        } catch {
                print(error.localizedDescription)
            }
    }
}
