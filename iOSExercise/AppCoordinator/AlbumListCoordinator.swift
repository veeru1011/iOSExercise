//
//  AlbumListCoordinator.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

class AlbumListCoordinator: ObservableObject, Identifiable {

    // MARK: Stored Properties

    @Published var viewModel: AlbumListViewModel!
    @Published var albumViewModel: AlbumViewModel?

    let appDataService : AppDataService

    // MARK: Initialization

    init(appDataService: AppDataService) {
        self.appDataService = appDataService
        self.viewModel = .init(appDataService, coordinator: self)
    }

    // MARK: Methods

    func open(_ album: UserAlbum) {
        self.albumViewModel = .init(appDataService, album)
    }

}
