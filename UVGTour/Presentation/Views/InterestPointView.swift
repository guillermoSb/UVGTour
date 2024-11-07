//
//  InterestPointView.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 10/24/24.
//

import SwiftUI

struct InterestPointView: View {
    let name: String
    var body: some View {
        HStack {
            Image(systemName: "mappin")
            Text(name)
        }
        .foregroundStyle(.black)
        .font(.caption2)
        .fontWeight(.semibold)
        .padding(.vertical, Sizes.p8)
        .frame(width: 100)
        .background(.white)
        .cornerRadius(Sizes.p12)
    }
}

#Preview {

    ZStack {
        Color.gray.ignoresSafeArea()
        InterestPointView(name: "Salon J")
    }
}
