//
//  AudioPlayer.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/16/23.
//

import AVFoundation
import SwiftUI

class AudioPlayer: NSObject, ObservableObject {
    private var player: AVAudioPlayer?
    var audio: String?
    @Published var isPlaying: Bool = false
    
    override init() {
        super.init()
        if let path = Bundle.main.path(forResource: audio, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player?.delegate = self
                player?.prepareToPlay()
            } catch {
                print("An error occurred: \(error.localizedDescription)")
            }
        }
    }
    
    func play() {
        player?.play()
        isPlaying = true
    }
    
    func stop() {
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
    }
}

extension AudioPlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            isPlaying = false
        }
    }
}
