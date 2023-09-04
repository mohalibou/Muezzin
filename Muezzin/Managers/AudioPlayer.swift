//
//  AudioPlayer.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 8/25/23.
//

import AVFoundation
import SwiftUI

class AudioPlayer: NSObject, ObservableObject {
    private var player: AVAudioPlayer?
    @Published var audio: Sound? {
        didSet {
            setupPlayer()
        }
    }
    @Published var nextAudio: Sound?
    @Published var isPlaying: Bool = false
    
    func setupPlayer() {
        if let path = Bundle.main.path(forResource: audio?.rawValue, ofType: "mp3") {
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
            // Check if there's a next audio to play
            if let next = nextAudio {
                audio = next
                play()
                nextAudio = nil // Reset nextAudio after playing
            }
        }
    }
}
