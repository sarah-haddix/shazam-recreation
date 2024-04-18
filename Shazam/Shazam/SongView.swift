//
//  SongView.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/14/24.
//

import SwiftUI

// TODO: Fix spacing, sizing, color

struct SongView: View {
    @StateObject var songsViewModel = SongsViewModel()
    var body: some View {
        VStack {
            topView
            ScrollView {
                HStack {
                    Text("My Music")
                        .foregroundStyle(.white)
                        .font(.title)
                        .bold()
                    Spacer()
                }
            }
        }
        .background(.black)
    }
}


private var topView: some View {
    // TODO: top bar thing
    HStack {
        Button {
            // TODO: settings view
        } label: {
            Image(systemName: "gearshape.fill")
                .font(.title)
                .foregroundStyle(.white)
        }
        Spacer()
        Button {
            // TODO: add search view
        } label: {
            ZStack {
                Circle()
                    .frame(width: 35)
                    .foregroundStyle(.gray)
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.red)
            }
        }
    }
}

/*
        Text("\(songsViewModel.allSongs.first?.title ?? "unwrapped")")
        
        AsyncImage(url: songsViewModel.allSongs.first?.albumArtURL) { image in
            image
                .resizable()
                .frame(width: 300, height: 300)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
        } placeholder: {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.purple.opacity(0.5))
                .frame(width: 300, height: 300)
                .cornerRadius(10)
                .redacted(reason: .privacy)
        }

*/



#Preview {
    SongView()
}
