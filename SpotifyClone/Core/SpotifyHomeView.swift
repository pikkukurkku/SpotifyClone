//
//  SwiftUIView.swift
//  SpotifyClone
//
//  Created by Natalia Ogorek on 28.03.25.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct SpotifyHomeView: View {
    
    @Environment(\.router) var router
    
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
    guard products.isEmpty else { return }
    do {
        currentUser = try await DatabaseHelper().getUsers().first
        products = try await Array(DatabaseHelper().getProducts().prefix(8))
        
        
        print("Fetched \(products.count) products")
        
        var rows: [ProductRow] = []
        let allBrands = Set(products.map { $0.brand ?? "Unknown" })
        for brand in allBrands {
 
                rows.append(ProductRow(titleText: brand, products: products))
        }
        productRows = rows
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
                            router.dismissScreen()
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
                .asButton(.press) {
                    goToPlaylistView(product: product)
                }
            }
        }
    }
    
    
    private func goToPlaylistView(product: Product) {
        guard let currentUser else { return }
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: currentUser)
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
                goToPlaylistView(product: product)
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
                      HStack(alignment: .top, spacing: 8) {
                          ForEach(row.products) { product in
                              ImageTitleRowCell(
                                  imageName: product.firstImage,
                                  title: product.title,
                                  imageSize: 120
                              )
                              .asButton(.press) {
                                goToPlaylistView(product: product)
                          }
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
    RouterView { _ in
        SpotifyHomeView()
    }
}
