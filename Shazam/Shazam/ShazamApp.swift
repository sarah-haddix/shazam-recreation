//
//  ShazamApp.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/13/24.
//

// TODO: clean up comments, maybe get rid of SongsViewModel, test audio on/off, FoundSongView, add more songs, fix alignment if you can
// TODO: FIX SHAZAMVIEW button - don't show foundsongview

import SwiftUI

@main
struct ShazamApp: App {
    var body: some Scene {
        WindowGroup {
            ShazamView()
        }
    }
}
