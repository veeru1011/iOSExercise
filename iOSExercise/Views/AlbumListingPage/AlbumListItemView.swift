//
//  AlbumListItemView.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import SwiftUI

struct AlbumListItemView: View {
    var album : UserAlbum
    
    var body: some View {
        VStack {
            Text(album.title ?? "")
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 100)
        .background(.gray)
        .cornerRadius(10)
    }
}

//struct AlbumListView_Previews: PreviewProvider {
//    static var previews: some View {
//        AlbumListItemView()
//    }
//}
