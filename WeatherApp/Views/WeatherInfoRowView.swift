//
//  WeatherInfoRowView.swift
//  WeatherApp
//
//  Created by rentamac on 1/27/26.
//

import SwiftUI

struct WeatherInfoRowView: View {
    let title1: String
    let value1: String
    let title2: String
    let value2: String
    
    var body: some View {
        HStack(spacing: 0) {
            WeatherCardView(title: title1, value: value1)
                .frame(maxWidth: .infinity)
            Spacer()
            Spacer()
            WeatherCardView(title: title2, value: value2)
                .frame(maxWidth: .infinity)
        }
    }
}
#Preview {
    WeatherInfoRowView(title1: "Title 1", value1: "Value 1", title2: "Title 2", value2: "Value 2")
}
