//
//  AlbumListViewModel.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

final class AlbumListViewModel: ObservableObject {
    
    let appDataService : AppDataService
    
    private weak var coordinator: AlbumListCoordinator?
    
    init(_ dataService : AppDataService, coordinator: AlbumListCoordinator) {
        self.appDataService = dataService
        self.coordinator = coordinator
    }
    
    var user : User? = nil {
        didSet {
            self.fetch()
        }
    }
    @Published var albums: [UserAlbum] = []
    @Published var errorMag: String?
    @Published var isLoading: Bool = true
    
    func fetchUserAndAlbums() {
        guard self.user == nil else { self.fetch(); return }
        appDataService.fetchUsers { result in
            switch result {
            case .success(let response):
                self.user = response
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMag = error.localizedDescription
                }
            }
        }
    }
    
    func fetch() {
        guard let id = user?.id else { return }
        appDataService.fetchAlbums(userId: id) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.albums = response
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMag = error.localizedDescription
                }
            }
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    // MARK: Methods

    func open(_ album: UserAlbum) {
        self.coordinator?.open(album)
    }
}
