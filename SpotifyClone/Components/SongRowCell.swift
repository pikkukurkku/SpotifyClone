//
//  SongRowCell.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 01.04.25.
//

import SwiftUI

struct SongRowCell: View {
    
    var imageSize: CGFloat = 50
  //  var product: Product = .mock
    var imageName: String = Constants.randomImage
    var title: String = "Some song name goes hereS"
    var subtitle: String? = "Some artist name"
    var onCellPressed: (() -> Void)? = nil
    var onEllipsisPressed: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 8) {
            ImageLoaderView(urlString: imageName)
                //.resizable()
               // .aspectRatio(contentMode: .fill)  // Adjust the content mode if necessary
                   .frame(width: imageSize, height: imageSize)  // Set a size for the image
               //    .clipped()
               // .background(Color.red)
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(.spotifyWhite)
                if let subtitle {
                    Text(subtitle)
                        .font(.callout)
                        .foregroundStyle(.spotifyLightGray)
                }
            }
            .lineLimit(2)
           .frame(maxWidth: .infinity, alignment: .leading)
            Image(systemName: "ellipsis")
                .font(.subheadline)
                .foregroundStyle(.spotifyWhite)
                .padding(16)
                .background(Color.black.opacity(0.001))
                .onTapGesture {
                    onEllipsisPressed?()
                }
        }
        .onTapGesture {
            onCellPressed?()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        VStack {
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
            SongRowCell()
        }
    }
}
