//
//  NetflixHomeView.swift
//  NetflixClone
//
//  Created by Mauricio Figueroa on 06-05-24.
//

import Foundation
import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    @State private var heroMovie: Media? = nil
    @State private var mediaContentSections: [MediaContent] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 8) {
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroMovie {
                        heroCell(with: heroMovie)
                    }
                    
                    moviesSections
                }
            }
            .scrollIndicators(.hidden)
            
            VStack(spacing: .zero) {
                header
                    .padding(.horizontal, 16)
                
                filtersBarView
            }
            .background(.netflixRed)
            .readingFrame { frame in
                fullHeaderSize = frame.size
            }
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await loadMovies()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var header: some View {
        HStack(spacing: .zero) {
            Text("For Mauricio")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                Image(systemName: "magnifyingglass")
            }
            .font(.title2)
        }
    }
    
    private var filtersBarView: some View {
        NetflixFilterBarView(
            filters: filters,
            onXMarkPressed: {
                selectedFilter = nil
            }, onFilterPressed: { newFilter in
                selectedFilter = newFilter
            },
            selectedFilter: selectedFilter)
        .padding(.top, 16)
    }
    
    private func heroCell(with heroMovie: Media) -> some View {
        NetflixHeroCell(title: heroMovie.title,
                        imageURL: heroMovie.imageURL,
                        categories: heroMovie.categories,
                        isNetflixFilm: true,
                        onBackgroundPressed: {
            
        }, onPlayPressed: {
            
        }, onMyListPressed: {
            
        })
        .padding(20)
    }
    
    private var moviesSections: some View {
        LazyVStack(alignment: .leading, spacing: 16) {
            ForEach(Array(mediaContentSections.enumerated()), id: \.offset) { (sectionIndex, section) in
                Text(section.title)
                    .font(.title2)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(Array(section.media.enumerated()), id: \.offset) { (index, media) in
                            NetflixMovieCell(
                                title: media.title,
                                imageURL: media.imageURL,
                                isRecentlyAdded: media.isRecentlyAdded,
                                topTenRanking: sectionIndex == 0 || sectionIndex == 1 ? index + 1: nil)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    private func loadMovies() async {
        guard let url = URL(string: "https://run.mocky.io/v3/8c2d40d1-b182-413c-8a89-f7e80ae710a3") else {
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            mediaContentSections = try JSONDecoder().decode([MediaContent].self, from: data)
            heroMovie = mediaContentSections.first?.media.first
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NetflixHomeView()
}
