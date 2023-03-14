//
//  AlbumListView.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import SwiftUI

struct AlbumListView: View {
    
    @ObservedObject  var viewModel : AlbumListViewModel
    
    var columns: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.albums) { album in
                        AlbumListItemView(album: album)
                            .onNavigation {
                            viewModel.open(album)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchUserAndAlbums()
            }
            if viewModel.isLoading {
                Spacer()
                ProgressView("Loading...")
            }
        }
    }
}
