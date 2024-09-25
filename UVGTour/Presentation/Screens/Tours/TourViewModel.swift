//
//  TourViewModel.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/24/24.
//

import Foundation
import Combine

class TourViewModel: ObservableObject {
    // MARK: State
    @Published private(set) var tour: Tour
    @Published private(set) var sensors: [Sensor] = []
    @Published private(set) var nextStopDirection: Float? = nil
    
    
    var distanceToStopSensor: Int? {
        let nextStop = tour.nextStop
        let sensor = sensors.first { sensor in
            sensor.id == nextStop.sensorId
        }
        guard let sensor else { return nil }
        return Int(sensor.distance)
    }
    var isInStopSensor: Bool {
        if let distanceToStopSensor {
            let arriveThreshold = 0
            return distanceToStopSensor <= arriveThreshold
        }
        return false
    }
    var sensorsRepository: SensorRepository
    var watchSensorsUseCase: WatchSensorsUseCase
    
    
    init(tour: Tour, sensorsRepository: SensorRepository) {
        self.tour = tour
        self.sensorsRepository = sensorsRepository
        self.watchSensorsUseCase = WatchSensorsUseCase(sensorsRepository: sensorsRepository)
        listenToSensors()
    }
    
    
    /// Listen to sensor updates
    func listenToSensors() {
        print("Listening to sensors...")
        self.watchSensorsUseCase.watchSensors { sensors in
            self.sensors = sensors
            // If close to a stop, mark it as visited
            if let distanceToStopSensor = self.distanceToStopSensor, distanceToStopSensor <= 0 {
                self.tour.visited(self.tour.nextStop)
            }
            // Get the closest sensor
            if let closestSensor = sensors.sorted(by: {$0.distance < $1.distance}).first {
                if closestSensor.distance <= 0 {
                    self.nextStopDirection = self.tour.getNextDirection(sensorId: closestSensor.id)
                    print("Next stop direction: \(self.nextStopDirection)")
                }
                
            }
            
        }
    }
    
    
    /// Goes to the next stop.
    func nextStop() {
        self.tour.completeStop()
    }
    
    
    /// Mark a ``[[Stop]]`` as visited
    func visited(stop: Stop) {
        self.tour.visited(stop)
    }
}
