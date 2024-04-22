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
            .zIndex(1)
            .padding(.bottom, -20)
            ZStack {
                UnevenRoundedRectangle
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 0
                    )
                    .frame(width: 160, height: 110)
                    .foregroundStyle(.appDarkGray)
                VStack(alignment: .leading) {
                    Text(song.title ?? "Title")
                        .foregroundStyle(.appSecondary)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Text(song.artistName ?? "Artist Name")
                        .foregroundStyle(.appGrey)
                        .font(.caption)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                }
                .frame(width: geometry.size.width*0.45)
            }
            }
    }
}

struct IndividualSongView_Previews: PreviewProvider {
    struct PreviewWrapper: View {

        var body: some View {
            GeometryReader { geometry in
                IndividualSongView(song: ShazamMedia(title: "Burn", subtitle: "Shadowglow", artistName: "flipturn", albumArtURL: URL(string: "https://images.genius.com/ae1509bf071456ff3a22c0689cdafa16.1000x1000x1.png"), genres: ["Null"]), geometry: geometry)
            }
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}




//saved view:
/*
var body: some View {
        VStack(alignment: .center, spacing: -10) {
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
            ZStack {
                UnevenRoundedRectangle
                    .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 10,
                        bottomTrailingRadius: 10,
                        topTrailingRadius: 0
                    )
                    .frame(width: 160, height: 110)
                VStack(alignment: .leading) {
                    Text(song.title ?? "Title")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Text(song.artistName ?? "Artist Name")
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                }
                .frame(width: geometry.size.width*0.45)
            }
            }
    }
*/

/*
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
            VStack {
                VStack(alignment: .leading) {
                    Text(song.title ?? "Title")
                        .foregroundStyle(.white)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    Text(song.artistName ?? "Artist Name")
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                }
                .frame(width: geometry.size.width*0.3)
                .padding()
                .backgroundColor(.black)
            }
            }
    }
*/
