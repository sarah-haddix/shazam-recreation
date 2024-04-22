//
//  SongsViewModel.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/20/24.
//

import Foundation

class SongsViewModel: ObservableObject {
    @Published var songs: [ShazamMedia] = []
    
    init() {
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
