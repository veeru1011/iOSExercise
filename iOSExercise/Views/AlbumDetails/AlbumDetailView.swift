//
//  AlbumDetailView.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import SwiftUI

struct AlbumDetailView: View {
    @StateObject  var viewModel : AlbumViewModel
    @State var presentingModal = false
    @State var selectedPhoto : UserPhoto?
    
    init(viewModel:AlbumViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var columns: [GridItem] {
        [GridItem(.flexible()), GridItem(.flexible())]
    }
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.photos) { photo in
                        PhotoItemView(photo: photo)
                            .onTapGesture {
                            self.selectedPhoto = photo
                            presentingModal = true
                        }
                    }
                }
            }
            .padding()
            .onAppear {
                viewModel.fetch()
            }
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationBarTitle(Text(viewModel.album.title ?? ""))
        .sheet(isPresented: $presentingModal) {
            PhotoDetailView(photo: self.$selectedPhoto, presentedAsModal: self.$presentingModal)
        }
    }
}
