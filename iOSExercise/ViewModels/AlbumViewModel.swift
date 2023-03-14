//
//  AlbumViewModel.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import Foundation

final class AlbumViewModel: ObservableObject {
    
    let appDataService : AppDataService
    let album : UserAlbum
    
    init(_ dataService : AppDataService,_ album : UserAlbum) {
        self.appDataService = dataService
        self.album = album
    }
        
    @Published var photos: [UserPhoto] = []
    @Published var errorMag: String?
    @Published var isLoading: Bool = true
    
    func fetch() {
        appDataService.fetchPhotos(albumId: album.id) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.photos = response
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
}
