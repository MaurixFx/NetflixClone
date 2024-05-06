//
//  NetflixHomeView.swift
//  NetflixClone
//
//  Created by Mauricio Figueroa on 06-05-24.
//

import Foundation
import SwiftUI

struct NetflixHomeView: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            
            VStack(spacing: .zero) {
                header
                    .padding(.horizontal, 16)
                
                NetflixFilterBarView(
                    filters: filters,
                    onXMarkPressed: {
                        selectedFilter = nil
                    }, onFilterPressed: { newFilter in
                        selectedFilter = newFilter
                    },
                    selectedFilter: selectedFilter)
                .padding(.top, 16)
                
                Spacer()
            }
        }
        .foregroundStyle(.netflixWhite)
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
}

#Preview {
    NetflixHomeView()
}
