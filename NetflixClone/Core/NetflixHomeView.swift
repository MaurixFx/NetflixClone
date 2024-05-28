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
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            backgroundGradientLayer
            
            scrollViewLayer
            
            fullHeaderWithFiltersView
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await loadMovies()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var fullHeaderWithFiltersView: some View {
        VStack(spacing: .zero) {
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -20 {
                filtersBarView
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(Color.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
        }
    }
    
    private var backgroundGradientLayer: some View {
        ZStack {
            LinearGradient(colors: [.netflixGray.opacity(1), .netflixGray.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LinearGradient(colors: [.netflixDarkRed.opacity(0.5), .netflixGray.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, (400 + (scrollViewOffset * 0.75))))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
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
    
    private var scrollViewLayer: some View {
        ScrollViewWithOnScrollChanged(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                Rectangle()
                    .opacity(0)
                    .frame(height: fullHeaderSize.height)
                
                if let heroMovie {
                    heroCell(with: heroMovie)
                }
                
                moviesSections
            }
        } onScrollChanged: { offset in
            scrollViewOffset = min(0, offset.y)
        }
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
        guard let contentSections: [MediaContent] = JSONReader.readJSONFromFile(fileName: "movie") else {
            return
        }
        
        mediaContentSections = contentSections
        heroMovie = mediaContentSections.first?.media.first
    }
}

#Preview {
    NetflixHomeView()
}
