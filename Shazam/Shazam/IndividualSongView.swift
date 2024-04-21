//
//  IndividualSongView.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/21/24.
//

import SwiftUI

struct IndividualSongView: View {
    let song: ShazamMedia
    let geometry: GeometryProxy
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: song.albumArtURL) { image in
                image
                    .resizable()
                    .frame(width: 160, height: 160)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
            } placeholder: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.purple.opacity(0.5))
                    .frame(width: 160, height: 160)
                    .cornerRadius(10)
                    .redacted(reason: .privacy)
            }
            VStack(alignment: .center) {
                Text(song.title ?? "Title")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width*0.45)
                Text(song.artistName ?? "Artist Name")
                    .font(.title2)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .frame(width: geometry.size.width*0.45)
            }
        }
    }
}

struct IndividualSongView_Previews: PreviewProvider {
    struct PreviewWrapper: View {

        var body: some View {
            GeometryReader { geometry in
                IndividualSongView(song: ShazamMedia(title: "The Blarney Stone", subtitle: "The Mollusk", artistName: "Ween", albumArtURL: URL(string: "https://images.genius.com/b141c1101ca8ccfb1edddc69f7784a51.1000x1000x1.jpg"), genres: ["Null"]), geometry: geometry)
            }
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
