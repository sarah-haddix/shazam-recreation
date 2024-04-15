//
//  ContentViewModel.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/13/24.
//

import Foundation

import ShazamKit
import AVKit // for using microphone
import AVFoundation



class ContentViewModel: NSObject, ObservableObject {
    @Published var shazamMedia = ShazamMedia(title: "Title...", subtitle: "Subtitle...", artistName: "Artist Name...", albumArtURL: URL(string: "https://google.com"), genres: ["Pop"])
    
    @Published var isRecording = false
    
    private let audioEngine = AVAudioEngine()
    private let session = SHSession()
    private let signatureGenerator = SHSignatureGenerator()
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    public func startOrEndListening() {
        guard !audioEngine.isRunning else {
            audioEngine.stop()
            DispatchQueue.main.async {
                self.isRecording = false
            }
            return
        }
        
        
        
        
        // let audioSession = AVAudioSession.sharedInstance()
        let audioSession = AVAudioSession.sharedInstance()
        
        let audioApplication = AVAudioApplication.self
        
        print("checkpoingt1")
        
        audioApplication.requestRecordPermission { granted in
            print("checkpoing2")
            guard granted else {
                print("checkpoing3")
                return
            }
            print("checkpoing4")
           // try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            
          
            do {
                try audioSession.setCategory(.playAndRecord, mode: .default)
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            } catch {
                print("Audio session setup failed: \(error)")
            }
            
            print("checkpoint5")
            let inputNode = self.audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0,
                                 bufferSize: 1024,
                                 format: recordingFormat) { (buffer: AVAudioPCMBuffer,
                                                             when: AVAudioTime) in
                self.session.matchStreamingBuffer(buffer, at: nil)
            }
            self.audioEngine.prepare()
            do {
                try self.audioEngine.start()
            } catch (let error) {
                assertionFailure(error.localizedDescription)
            }
            DispatchQueue.main.async {
                self.isRecording = true
            }
        }
    }
}

extension ContentViewModel: SHSessionDelegate {
    // success case
    func session(_ session: SHSession, didFind match: SHMatch) {
        let mediaItems = match.mediaItems
        
        if let firstItem = mediaItems.first {
            let _shazamMedia = ShazamMedia(title: firstItem.title, subtitle: firstItem.subtitle, artistName: firstItem.artist, albumArtURL: firstItem.artworkURL, genres: firstItem.genres)
            DispatchQueue.main.async {
                self.shazamMedia = _shazamMedia
            }
        }
    }
}
