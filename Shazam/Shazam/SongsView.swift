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
    @ObservedObject var vm: ContentViewModel
    
    // Define the grid layout
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 0),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    ZStack {
                        VStack {
                            Rectangle()
                                .foregroundColor(.appSecondary)
                                .frame(width: 40, height: 4)
                                .cornerRadius(10)
                                .padding(.top)
                            HStack {
                                Text("My Music")
                                    .foregroundStyle(.appSecondary)
                                    .font(showingMenu ? Font.system(size: 40) : .title2)
                                    .fontWeight(.bold)
                                    //.padding()
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                    .padding(.bottom)
                                    .animation(.easeInOut(duration: 0.25), value: showingMenu)
                                Spacer()
                                Text("\(vm.songs.count) Shazams")
                                    .foregroundStyle(.appGrey)
                                    .font(.callout)
                                    .fontWeight(.bold)
                                   // .padding()
                                    .padding(.horizontal)
                                    .padding(.bottom)
                                    .padding(.bottom)
                                    .opacity(showingMenu ? 0 : 1)
                            }
                        }
                        
                        
                    Button {
                        showingMenu = true;
                    } label: {
                        Rectangle()
                            .frame(width: geometry.size.width, height: 50)
                           // .foregroundStyle(.red)
                            .opacity(0)
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
                }
                    .padding(.bottom, -20)
                    
                   // Spacer()
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 30) {
                            ForEach(vm.songs, id: \.title) { song in
                                IndividualSongView(song: song, geometry: geometry)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.appPrimary)
                .edgesIgnoringSafeArea(.all)
            }
        }
    }
}


struct SongsView_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var showingMenu = false

        var body: some View {
            SongsView(showingMenu: $showingMenu, vm: ContentViewModel())
        }
    }

    static var previews: some View {
        PreviewWrapper()
    }
}
