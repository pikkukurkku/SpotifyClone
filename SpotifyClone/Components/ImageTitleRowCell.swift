//
//  ImageTitleRowCell.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 31.03.25.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    let imageName: String
    let title: String
    var imageSize: CGFloat = 100
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: imageSize, height: imageSize)
                
            Text(title)
                .foregroundStyle(.spotifyLightGray)
                .font(.callout)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: imageSize)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ImageTitleRowCell(imageName: Constants.randomImage, title: "some title")

    }

}
