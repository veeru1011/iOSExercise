//
//  ContentView.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import SwiftUI

struct MainHomeView: View {
    
    @ObservedObject var coordinator: AlbumListCoordinator
    
    var body: some View {
        NavigationView {
            AlbumListView(viewModel: coordinator.viewModel)
                .navigation(item: $coordinator.albumViewModel) { viewModel in
                    AlbumDetailView(viewModel:viewModel)
            }
            .navigationBarTitle(Text("Albums"))
        }
    }
}


