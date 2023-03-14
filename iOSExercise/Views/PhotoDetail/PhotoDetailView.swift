//
//  PhotoDetailView.swift
//  iOSExercise
//
//  Created by mac on 14/03/23.
//

import SwiftUI

struct PhotoDetailView: View {
    @Binding var photo : UserPhoto?
    @Binding var presentedAsModal: Bool
    var body: some View {
        VStack {
            if let userPhoto = photo {
                Text(userPhoto.title ?? "")
                    .padding()
                    .frame(minHeight: 100, maxHeight: 100)
                GeometryReader { _ in
                    AsyncImage(url: URL(string: userPhoto.thumbnailUrl ?? "")) { image in
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
            }
            else {
                EmptyView()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity,minHeight: 100)
        .cornerRadius(5)
    }
}
