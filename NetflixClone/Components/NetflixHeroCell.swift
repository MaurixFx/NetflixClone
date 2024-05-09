//
//  NetflixHeroCell.swift
//  NetflixClone
//
//  Created by Mauricio Figueroa on 06-05-24.
//

import SwiftUI
import SDWebImageSwiftUI
import SwiftfulUI

struct NetflixHeroCell: View {
    var title: String = "Players"
    var imageURL: String = "https://i.etsystatic.com/23402008/r/il/5c021e/2326618902/il_fullxfull.2326618902_brqu.jpg"
    var categories: [Category] = [.action, .drama]
    var isNetflixFilm: Bool = true
    var onBackgroundPressed: (() -> Void)? = nil
    var onPlayPressed: (() -> Void)? = nil
    var onMyListPressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            WebImage(url: URL(string: imageURL))
                .resizable()
            
            VStack(spacing: 16) {
                VStack(spacing: 0) {
                    if isNetflixFilm {
                        HStack(spacing: 8) {
                            Text("NEX")
                                .foregroundStyle(.netflixRed)
                                .font(.largeTitle)
                                .fontWeight(.black)
                            
                            Text("CLONE")
                                .kerning(3)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.netflixWhite)
                        }
                    }
                    
                    Text(title)
                        .font(.system(size: 50, weight: .medium, design: .serif))
                }
                
                HStack(spacing: 8) {
                    ForEach(categories, id: \.self) { category in
                        Text(category.rawValue.capitalized)
                            .font(.callout)
                        
                        if category != categories.last {
                            Circle()
                                .frame(width: 4, height: 4)
                        }
                    }
                }
                
                HStack(spacing: 16) {
                    Button(action: {
                        onPlayPressed?()
                    }, label: {
                        Image(systemName: "play.fill")
                        Text("Play")
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixGray)
                    .background(.netflixWhite)
                    .cornerRadius(4)
                    
                    Button(action: {
                        onMyListPressed?()
                    }, label: {
                        Image(systemName: "plus")
                        Text("My List")
                    })
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .foregroundStyle(.netflixWhite)
                    .background(.netflixGray)
                    .cornerRadius(4)
                }
                .font(.callout)
                .fontWeight(.medium)
            }
            .padding(24)
            .background(LinearGradient(colors: [
                .netflixBlack.opacity(0), .netflixBlack.opacity(0.8)
            ], startPoint: .top, endPoint: .bottom))
        }
        .foregroundStyle(.netflixWhite)
        .cornerRadius(10)
        .aspectRatio(0.8,  contentMode: .fit)
        .asButton(.tap) {
            onBackgroundPressed?()
        }
    }
}

#Preview {
    NetflixHeroCell()
        .padding(40)
}
