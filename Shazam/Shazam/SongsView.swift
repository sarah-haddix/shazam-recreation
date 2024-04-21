//
//  SongsView.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/20/24.
//

import SwiftUI

struct SongsView: View {
    @Binding var showingMenu: Bool;
    @State private var isDragging = false;
    @ObservedObject var vm: SongsViewModel
    
    // Define the grid layout
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    Button {
                        showingMenu = true;
                    } label: {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 100)
                            .foregroundStyle(.red)
                            .padding(.vertical)
                    }
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                self.isDragging = true
                            }
                            .onEnded { _ in
                                self.isDragging = false
                                // Perform the button's action
                                showingMenu = true;
                            }
                    )
                    Spacer()
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(vm.songs, id: \.title) { song in
                                IndividualSongView(song: song, geometry: geometry)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.blue)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}


struct SongsView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var showingMenu = false

        var body: some View {
            SongsView(showingMenu: $showingMenu, vm: SongsViewModel())
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
