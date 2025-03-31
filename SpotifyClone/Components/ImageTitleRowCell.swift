//
//  ImageTitleRowCell.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 31.03.25.
//

import SwiftUI

struct ImageTitleRowCell: View {
    
    let imageName: String = Constants.randomImage
    let title: String = "Some item name nake name name anme "
    var ImageSize: CGFloat = 100
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            ImageLoaderView(urlString: imageName)
                .frame(width: ImageSize, height: ImageSize)
                
            Text(title)
                .foregroundStyle(.spotifyLightGray)
                .font(.callout)
                .lineLimit(2)
                .padding(4)
        }
        .frame(width: ImageSize)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        ImageTitleRowCell()
    }

}
