//
//  WeatherCardView.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import SwiftUI

struct WeatherCardView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
            
            Text(value)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(.orange)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
#Preview {
    WeatherCardView(title: "Hello", value: "World")
}