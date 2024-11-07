//
//  TourScreen.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/24/24.
//

import SwiftUI
import Combine
import CoreLocation

/// Screen for allowing the progression of a ``[[Tour]]``
struct TourScreen: View {
    @StateObject var tourViewModel: TourViewModel
    @ObservedObject var locationManager = LocationManager()
    @EnvironmentObject var tourselection: TourSelection
    @State var angle: Float = 0
    @State var showArrow = false
    @State var showTourListScreen = false
    
    var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.gray.ignoresSafeArea()
            ARTourView(angle: $angle, showArrow: $showArrow)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .ignoresSafeArea()
            
            VStack(spacing: Sizes.p24) {
                Button(action: {
                    showTourListScreen = true
                }, label: {
                    Text("🧭")
                        .padding()
                        .background(.lightBackground)
                        .clipShape(Circle())
                })
                Button(action: {
                    
                }, label: {
                    Text("🔎")
                        .padding()
                        .background(.lightBackground)
                        .clipShape(Circle())
                })
            }
            .padding(Sizes.p24)
            .padding(.top, 100)
            
            if let interestPoint = tourViewModel.interestPoint {
                InterestPointView(name: interestPoint.name)
                      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                      .padding()
                      .offset(y: 150)
            }
            
            
            VStack(spacing: Sizes.p12) {
                Image("uvg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                Spacer()
                if let distanceToClosest = tourViewModel.distanceToClosest {
                    Text("\(distanceToClosest)")
                }
                
                if let distanceToStopSensor = tourViewModel.distanceToStopSensor, tourselection.selectedTour != nil {
                    DistanceIndicatorView(distance: distanceToStopSensor )
                        .offset(y: Sizes.p24)
                        .opacity(tourViewModel.tour.completed ? 0 : 1)
                }
                TourProgressView()
                    .padding(.horizontal, Sizes.p24)
                    .padding(.bottom, Sizes.p24)
                    .opacity(tourselection.selectedTour != nil ? 1 : 0)
                    .environmentObject(tourViewModel)
            }
        }
        .sensoryFeedback(.success, trigger: tourViewModel.tour.nextStop)
        .onChange(of: tourViewModel.tour, { _, tour in
            let nextAngle = tourViewModel.nextStopDirection
            guard let nextAngle  else {
                return
            }
            let currentAngleDegrees = Float(locationManager.degrees)
            angle = (currentAngleDegrees * .pi / 180) + nextAngle
            
        })
        .onChange(of: locationManager.degrees) { oldValue, newValue in
            let nextAngle = tourViewModel.nextStopDirection
            if let nextAngle {
                let currentAngleDegrees = Float(locationManager.degrees)
                angle = (currentAngleDegrees * .pi / 180) + nextAngle
            }
        }
        .onChange(of: tourViewModel.nextStopDirection) { oldValue, newValue in
            showArrow = newValue != nil
            if let newValue {
                let currentAngleDegrees = Float(locationManager.degrees)
                angle = (currentAngleDegrees * .pi / 180) + newValue
            }
        }
        .onChange(of: tourViewModel.isInStopSensor) { oldValue, newValue in
            showArrow = !newValue && tourViewModel.tour.currentStop != nil
        }
        .onChange(of: tourselection.selectedTour, { oldValue, newValue in
            if let newValue {
                tourViewModel.selectTour(newValue)
            }
        })
        .sheet(isPresented: $showTourListScreen, content: {
            NavigationView {
                ToursListScreen(viewModel: ToursListViewModel(useCase: ListToursUseCase(toursRepository: ToursRepositoryImpl(datasource: LocalToursDatasource()))), show: $showTourListScreen)
                    .navigationTitle("Tours")
            }
            
        })
    }
    
}


#Preview {
    let tour = LocalToursDatasource.tours[0]
    let sensorsRepository = SensorRepositoryImpl(datasource: SocketIOSensorDatasource())
    let tourViewModel = TourViewModel(tour: tour, sensorsRepository: sensorsRepository)
    
    return NavigationView(content: {
        TourScreen(tourViewModel: tourViewModel)
    })
    .environmentObject(TourSelection())
    
}
