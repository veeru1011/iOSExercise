//
//  PhotoItemView.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import SwiftUI

struct PhotoItemView: View {
    var photo : UserPhoto
    
    var body: some View {
        VStack {
            GeometryReader { _ in
                AsyncImage(url: URL(string: photo.thumbnailUrl ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ZStack {
                        Color.gray
                        ProgressView("")
                    }
                }
            }
            .aspectRatio(1.0, contentMode: .fit)
            Text(photo.title ?? "")
                .padding()
                .frame(minHeight: 100, maxHeight: 100)
        }
        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 100)
        .background(.yellow)
        .cornerRadius(5)
    }
}
