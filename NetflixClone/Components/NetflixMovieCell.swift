//
//  NetflixMovieCell.swift
//  NetflixClone
//
//  Created by Mauricio Figueroa on 06-05-24.
//

import SwiftUI
import SDWebImageSwiftUI

struct NetflixMovieCell: View {
    var width: CGFloat = 90
    var height: CGFloat = 140
    var title: String? = "Movie title"
    var imageURL: String = "https://i.etsystatic.com/23402008/r/il/5c021e/2326618902/il_fullxfull.2326618902_brqu.jpg"
    var isRecentlyAdded: Bool = false
    var topTenRanking: Int? = nil
    
    var body: some View {
        HStack(alignment: .bottom, spacing: -4) {
            if let topTenRanking {
                Text("\(topTenRanking)")
                    .font(.system(size: 90, weight: .medium, design: .rounded))
                    .offset(y: 20)
            }
            
            ZStack(alignment: .bottom) {
                WebImage(url: URL(string: imageURL))
                    .resizable()
                
                VStack(spacing: 0) {
                    if let title, let firstWord = title.components(separatedBy: " ").first {
                        Text(firstWord)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .lineLimit(1)
                    }
                    
                    Text("Recently Added")
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .padding(.bottom, 2)
                        .frame(maxWidth: .infinity)
                        .background(.netflixRed)
                        .cornerRadius(2)
                        .offset(y: 2)
                        .lineLimit(1)
                        .font(.caption2)
                        .fontWeight(.bold)
                        .minimumScaleFactor(0.1)
                        .padding(.horizontal, 8)
                        .opacity(isRecentlyAdded ? 1 : 0)
                }
                .padding(.top, 6)
                .background(
                    LinearGradient(colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.3),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.5)
                    ], startPoint: .top, endPoint: .bottom)
                )
            }
            .cornerRadius(4)
            .frame(width: width, height: height)
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        ScrollView {
            VStack {
                NetflixMovieCell(isRecentlyAdded: false)
                NetflixMovieCell(isRecentlyAdded: true)
                NetflixMovieCell(isRecentlyAdded: false, topTenRanking: 6)
                NetflixMovieCell(isRecentlyAdded: false, topTenRanking: 10)
            }
        }
    }
}
