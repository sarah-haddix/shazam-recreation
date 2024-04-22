//
//  FoundSongView.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/21/24.
//

import SwiftUI

struct FoundSongView: View {
    @Environment(\.dismiss) var dismiss
    let song: ShazamMedia
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "x.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.appGrey)
                            .padding(.trailing)
                            .padding(.trailing)
                            .padding(.top)
                            .padding(.top)
                    }
                }
                Spacer()
                AsyncImage(url: song.albumArtURL) { image in
                    image
                        .resizable()
                        .frame(width: geometry.width, height: geometry.width)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                } placeholder: {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.purple.opacity(0.5))
                        .frame(width: geometry.width, height: geometry.width)
                        .cornerRadius(10)
                        .redacted(reason: .privacy)
                }
                VStack(alignment: .center) {
                    Text(song.title ?? "Title")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.appSecondary)
                        .multilineTextAlignment(.center)
                    Text(song.artistName ?? "Artist Name")
                        .font(.title2)
                        .foregroundColor(.appGrey)
                        .multilineTextAlignment(.center)
                }.padding()
                    .padding(.bottom)
                    .padding(.bottom)
                    .padding(.bottom)
                Spacer()
            }
            .frame(width: geometry.width)
            .backgroundColor(.appMediumGray)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    FoundSongView(song: ShazamMedia(title: "Dance Yrself Clean", subtitle: "This Is Happening", artistName: "LCD Soundsystem", albumArtURL: URL(string: "https://i.scdn.co/image/ab67616d0000b273ee0d0dce888c6c8a70db6e8b"), genres: ["Null"]))
}
