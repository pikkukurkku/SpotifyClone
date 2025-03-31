//
//  SwiftUIView.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 28.03.25.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: CategoryLabel? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders], content: {
                    Section {
                        VStack (spacing: 16){
                            recentsSection
                                .padding(.horizontal, 16)
                            if let product = products.first {
                                newReleaseSection(product: product)
                                    .padding(.horizontal, 16)
                            }
                            listRows
                        }
                    }  header: {
                    header
                }
                })
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }.task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
private func getData() async {
    do {
        currentUser = try await DatabaseHelper().getUsers().first
        products = try await Array(DatabaseHelper().getProducts().prefix(8))
        
        
        print("Fetched \(products.count) products")
        
        var rows: [ProductRow] = []
        let allBrands = Set(products.map { $0.brand ?? "Unknown" })
        for brand in allBrands {
            let filteredProducts = products.filter { $0.brand ?? "Unknown" == brand }
            if !filteredProducts.isEmpty {
                rows.append(ProductRow(titleText: brand, products: filteredProducts))
            }
        }
        productRows = rows
        print("Generated \(productRows.count) product rows")
        print("Fetched brands:", products.map { $0.brand as Any })  // Print actual values

    } catch {
        print("Error fetching data: \(error)")
        }
    }
    
    private var header: some View {
        HStack (spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(Circle())
                        .onTapGesture {
                            // later
                        }
                }
            }
            .frame(width: 35, height: 35)
    
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(CategoryLabel.allCases, id: \.self) { category in
                        SpotifyCategoryCell(
                            title: category.rawValue.capitalized,
                            isSelected: category == selectedCategory
                        )
                        .onTapGesture {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
   
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }
    
    private var recentsSection: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentsCell(
                    imageName: product.firstImage,
                    title: product.title
                )
            }
        }
    }
    
    private func newReleaseSection(product: Product)   -> some View {
        SpotifyNewReleaseCell(
            imageName: product.firstImage,
            headline: product.brand ?? "Brand Unavailable",
            subheadline: product.title,
            title: product.title,
            subtitle: product.description,
            onAddToPlaylistPressed: {
                
            },
            onPlayPressed: {
                
            }
        )
    }
    
    private var listRows: some View {
          ForEach(productRows) { row in
              VStack(spacing: 8) {
                  Text(row.titleText)
                      .font(.title)
                      .fontWeight(.semibold)
                      .foregroundStyle(.spotifyWhite)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding(.horizontal, 16)

                  ScrollView(.horizontal) {
                      HStack(alignment: .top, spacing: 16) {
                          ForEach(row.products) { product in
                              ImageTitleRowCell(
                                  imageName: product.firstImage,
                                  title: product.title,
                                  imageSize: 120
                              )
//                              .asButton(.press) {
//                                  goToPlaylistView(product: product)
//                              }
                          }
                      }
                      .padding(.horizontal, 16)
                  }
                  .scrollIndicators(.hidden)
              }
          }
      }
  }



#Preview {
    SpotifyHomeView()
}
