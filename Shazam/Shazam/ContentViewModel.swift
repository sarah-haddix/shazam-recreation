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
    @Published var songs: [ShazamMedia] = []
    @Published var isRecording: Bool = false
    @Published var showingFoundSong: Bool = false
    
    // audioEngine: An AVAudioEngine contains a group of connected AVAudioNodes (“nodes”), each of which performs an audio signal generation, processing, or input/output task.
    private let audioEngine = AVAudioEngine()
    // session: This is a part of the new ShazamKit framework. SHSession stands for ShazamSession that will be used to perform our audio requests to the server.
    private let session = SHSession()
    // signatureGenerator: SHSignatureGenerator provides a way to convert audio data into instances of SHSignature which is the required form of data that is required to be sent to the server for processing. Shazam will not process raw audio buffer data.
    private let signatureGenerator = SHSignatureGenerator()
    
    override init() {
        super.init()
        session.delegate = self
        self.songs.append(ShazamMedia(title: "Dance Yrself Clean", subtitle: "This Is Happening", artistName: "LCD Soundsystem", albumArtURL: URL(string: "https://i.scdn.co/image/ab67616d0000b273ee0d0dce888c6c8a70db6e8b"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "All I Want Is You", subtitle: "Music From The Motion Picture", artistName: "Barry Louis Polisar", albumArtURL: URL(string: "https://i1.sndcdn.com/artworks-ghxEyD8hCvEOmCj2-L61quA-t500x500.jpg"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "All My Love", subtitle: "Stick Season", artistName: "Noah Kahan", albumArtURL: URL(string: "https://i1.sndcdn.com/artworks-E1urVerPw2G2-0-t500x500.jpg"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "End of Beginning", subtitle: "DECIDE", artistName: "Djo", albumArtURL: URL(string: "https://i.scdn.co/image/ab67616d0000b273fddfffec51b4580acae727c1"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "Gonna Be Strange", subtitle: "Lighten Up", artistName: "Erin Rae", albumArtURL: URL(string: "https://f4.bcbits.com/img/a0893902109_10.jpg"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "Close Your Eyes", subtitle: "Waiting to Spill", artistName: "The Backseat Lovers", albumArtURL: URL(string: "https://images.genius.com/3c05986c21bb59f2b03e9ef004da11c8.1000x1000x1.jpg"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "Chateau Lobby #4", subtitle: "I Love You, Honeybear", artistName: "Father John Misty", albumArtURL: URL(string: "https://f4.bcbits.com/img/a4293527175_10.jpg"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "Burn", subtitle: "Shadowglow", artistName: "flipturn", albumArtURL: URL(string: "https://images.genius.com/ae1509bf071456ff3a22c0689cdafa16.1000x1000x1.png"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "It It Over Now? (Taylor's Version)", subtitle: "1989 (Taylor's Version", artistName: "Taylor Swift", albumArtURL: URL(string: "https://i1.sndcdn.com/artworks-D3dIn15wof2z-0-t500x500.jpg"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "Lonely Eyes", subtitle: "Ann", artistName: "The Front Bottoms", albumArtURL: URL(string: "https://i1.sndcdn.com/artworks-Ax4hupMd8w4i-0-t500x500.jpg"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "Annie's Song", subtitle: "Back Home Again", artistName: "John Denver", albumArtURL: URL(string: "https://i.scdn.co/image/ab67616d0000b2733c16761584c4015495bdda87"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "Take Me Home, Country Roads", subtitle: "Take Me Home, Country Roads", artistName: "Lana Del Rey", albumArtURL: URL(string: "https://media.pitchfork.com/photos/6569e758aeffcb2d53c81ac0/master/pass/Lana-Del-Rey.jpg"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "My Girl", subtitle: "Otis Blue (Mono)", artistName: "Otis Redding", albumArtURL: URL(string: "https://i.scdn.co/image/ab67616d0000b2738ce699251f50e7bc401523cc"), genres: ["Null"]))
        self.songs.append(ShazamMedia(title: "The Blarney Stone", subtitle: "The Mollusk", artistName: "Ween", albumArtURL: URL(string: "https://images.genius.com/b141c1101ca8ccfb1edddc69f7784a51.1000x1000x1.jpg"), genres: ["Null"]))
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
                print("@@@@@@@@@@@@@@@@@@@@@@@@")
                self.songs.insert(self.shazamMedia, at: 0)
                self.startOrEndListening()
                self.showingFoundSong = true
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
            audioEngine.inputNode.removeTap(onBus: 0)
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
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            
            print("Recording format: \(recordingFormat)")
            
            inputNode.installTap(onBus: 0,
                                 bufferSize: 1024,
                                 format: recordingFormat) { (buffer: AVAudioPCMBuffer,
                                                             when: AVAudioTime) in
//                print("SESSION CHECKPOINT2")
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



struct ShazamMedia: Decodable {
    let title: String?
    let subtitle: String?
    let artistName: String?
    let albumArtURL: URL?
    let genres: [String]
}
