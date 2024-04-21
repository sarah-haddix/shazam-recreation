//
//  ContentViewModel.swift
//  Testing2
//
//  Created by Sarah Haddix on 4/15/24.
//

import Foundation
import AVFoundation
import ShazamKit

class ContentViewModel: NSObject, ObservableObject {
    @Published var shazamMedia =  ShazamMedia(title: "Title...",
                                              subtitle: "Subtitle...",
                                              artistName: "Artist Name...",
                                              albumArtURL: URL(string: "https://google.com"),
                                              genres: ["Pop"])
    @Published var isRecording = false
    
    // audioEngine: An AVAudioEngine contains a group of connected AVAudioNodes (“nodes”), each of which performs an audio signal generation, processing, or input/output task.
    private let audioEngine = AVAudioEngine()
    // session: This is a part of the new ShazamKit framework. SHSession stands for ShazamSession that will be used to perform our audio requests to the server.
    private let session = SHSession()
    // signatureGenerator: SHSignatureGenerator provides a way to convert audio data into instances of SHSignature which is the required form of data that is required to be sent to the server for processing. Shazam will not process raw audio buffer data.
    private let signatureGenerator = SHSignatureGenerator()
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    
}

extension ContentViewModel: SHSessionDelegate {
    func session(_ session: SHSession, didFind match: SHMatch) {
        print("SESSION CHECKPOINT")
        let mediaItems = match.mediaItems
        
        if let firstItem = mediaItems.first {
            let _shazamMedia = ShazamMedia(title: firstItem.title,
                                           subtitle: firstItem.subtitle,
                                           artistName: firstItem.artist,
                                           albumArtURL: firstItem.artworkURL,
                                           genres: firstItem.genres)
            DispatchQueue.main.async {
                self.shazamMedia = _shazamMedia
            }
        }
    }
    
    func session(
        _ session: SHSession,
        didNotFindMatchFor signature: SHSignature,
        error: (any Error)?
    ) {
        print("ERROR HERE")
    }
    
    public func startOrEndListening() {
        guard !audioEngine.isRunning else {
            audioEngine.stop()
            DispatchQueue.main.async {
                self.isRecording = false
            }
            return
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        //let audioApplication = AVAudioApplication()
        AVAudioApplication.requestRecordPermission { granted in
            guard granted else { return }
            do {
                try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
                try audioSession.setCategory(.playAndRecord, mode: .default)
            } catch {
                print("ERROR OCCURED")
            }
            
            // The audio engine creates a singleton on demand when inputNode is first accessed. To receive input, connect another audio node from the output of the input audio node, or create a recording tap on it.
            let inputNode = self.audioEngine.inputNode
            
            // assume maybe something going on here
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            
            print("Recording format: \(recordingFormat)")
            
            inputNode.installTap(onBus: 0,
                                 bufferSize: 1024,
                                 format: recordingFormat) { (buffer: AVAudioPCMBuffer,
                                                             when: AVAudioTime) in
                print("SESSION CHECKPOINT2")
//                print("\(buffer.format)")
                
                
                
                self.session.matchStreamingBuffer(buffer, at: nil)
            }
            print("checkpoint7")
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



struct ShazamMedia: Decodable {
    let title: String?
    let subtitle: String?
    let artistName: String?
    let albumArtURL: URL?
    let genres: [String]
}
