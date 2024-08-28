//
//  TourProgressView.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/24/24.
//

import SwiftUI

/// Displays the tour progress and opens the stop detail view.
struct TourProgressView: View {
    @EnvironmentObject var tourViewModel: TourViewModel
    @State private var expanded: Bool = false
    
    var tour: Tour { tourViewModel.tour }
    var nextStop: Stop { tour.nextStop }
    var body: some View {
        VStack(spacing: 0) {
            Text(nextStop.emoji)
                .font(.title)
                .padding(Sizes.p20)
                .background(.lightBackground)
                .clipShape(Circle())
                .offset(y: Sizes.p24)
                .zIndex(1)
            if (expanded) {
                VStack {
                    TourStopView(stop: nextStop)
                    tourProgressContainer
                }
                .uvgTourContainer()
                
            } else {
                collapsedTourStopView
                    .uvgTourContainer()
            }
        }
        .onTapGesture {
            expanded.toggle()
        }
        .sensoryFeedback(.selection, trigger: expanded)
    }
    
    
    var collapsedTourStopView: some View {
        VStack {
            Text(tour.nextStop.name).font(.title3).bold()
            tourProgressContainer
        }
    }
   
    
    var tourProgressContainer: some View {
        VStack(alignment: .leading) {
            Text("\(tour.progress) de \(tour.stops.count) puntos")
            HStack {
                TourProgressIndicatorView(progress: Double(tour.progress) / Double(tour.stops.count))
                Spacer()
                Button("Siguiente") {
                    tourViewModel.nextStop()
                }
                .buttonStyle(BorderedProminentButtonStyle())
            }
        }
        .padding(.horizontal, Sizes.p24)
    }
}

#Preview {
    let tour = LocalToursDatasource.tours[0]
    let sensorsRepository = SensorRepositoryImpl(datasource: SocketIOSensorDatasource())
    let tourViewModel = TourViewModel(tour: tour, sensorsRepository: sensorsRepository)
    return ZStack(alignment: .bottom) {
        Color.gray.ignoresSafeArea()
        TourProgressView()
            .environmentObject(tourViewModel)
            
        
    }
    
}
