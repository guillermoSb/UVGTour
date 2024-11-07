//
//  UVGTourApp.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import SwiftUI

@main
struct UVGTourApp: App {

    var body: some Scene {
        let datasource = LocalToursDatasource()
        let repository = ToursRepositoryImpl(datasource: datasource)
        let useCase = ListToursUseCase(toursRepository: repository)
        let viewModel = ToursListViewModel(useCase: useCase)
        let tourSelection = TourSelection()
        WindowGroup {
            TourScreen(tourViewModel: TourViewModel(tour: LocalToursDatasource.tours[0], sensorsRepository: SensorRepositoryImpl(datasource: SocketIOSensorDatasource())))
                .environmentObject(tourSelection)
            
        }
    }
}
