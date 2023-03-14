//
//  iOSExerciseApp.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import SwiftUI

@main
struct iOSExerciseApp: App {
    
    @StateObject var coordinator = AlbumListCoordinator(appDataService: DataFetchService(networkService: NetworkFetchService(sessionManager: SessionManager())))
    
    var body: some Scene {
        WindowGroup {
            MainHomeView(coordinator: coordinator)
        }
    }
}
