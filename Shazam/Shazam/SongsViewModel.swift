//
//  SongsViewModel.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/14/24.
//

import Foundation

class SongsViewModel: ObservableObject {
    @Published var allSongs: [ShazamMedia] = [ShazamMedia.example]
}
