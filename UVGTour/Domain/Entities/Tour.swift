//
//  Tour.swift
//  UVGTour
//
//  Created by Guillermo Santos Barrios on 8/17/24.
//

import Foundation


/// A data representation of a tour.
///
/// A user can complete a Tour by following the stops.
struct Tour: Identifiable, Equatable {
    var id: String
    let name: String
    let description: String
    let duration: Duration
    private(set) var stops: [Stop]
    var currentStop: Stop? = nil
    
    var tourStops: [Stop] {
        stops.filter { !$0.isWaypoint }
    }
    
    
    var nextStop: Stop {
        guard let currentStop else { return stops[0] }
        // Get index for the currentStop
        let index = stops.firstIndex { s in
            s.id == currentStop.id
        }
        if index! + 1 > tourStops.count { return stops[0] }    // Fall back to first stop
        return tourStops[min(index! + 1, tourStops.count - 1)]
    }
    
    var completed: Bool {
        tourStops.filter {$0.completed}.count == tourStops.count
    }
    
    var willBeCompleted: Bool {
        tourStops.filter {$0.completed}.count == tourStops.count - 1
    }
    
    /// Exposes the total of stops the user has completed
    var progress: Int {
        let completeStops = tourStops.filter { $0.completed }
        return completeStops.count
    }
    
    /// Gets the next direction for the with a given ``sensorId``
    func getNextDirection(sensorId: String) -> Float? {
        if self.completed {
            return nil
        }
        guard let stop = self.stops.first(where: { s in
            s.sensorId == sensorId
        }) else { return nil }
        if nextStop == stops[0] {
            return nil
        }
        return stop.nextStopDirection
    }
    
    /// Gets an interest point to a sensor if the user is near it
    func getInterestPoint(sensorId: String, distance: Float) -> InterestPoint? {
        // Get stop with that sensorId
        guard let stop = self.stops.first(where: { stop in
            stop.sensorId == sensorId
        }) else { return nil }
        let interestPoints = stop.interestPoints.sorted { i1, i2 in
            distance - i1.distance < distance - i2.distance
        }
        // Get the closest interest point in a range of +- 0.5m
        guard let firstInterestPoint = interestPoints.first else {return nil}
        let distanceToInterestPoint = abs(distance - firstInterestPoint.distance)
        if distanceToInterestPoint <= 0.5 {
            return firstInterestPoint
        }
        if stop.completed {
            return nil
        }
        return nil
            
    }
    
    
    /// Marks a ``Stop`` as completed.
    mutating func completeStop() {
        currentStop = nextStop
        if let currentStop, let currentStopIndex = stops.firstIndex(of: currentStop) {
            stops[currentStopIndex].complete()
        }
    }
    
    /// Marks a ``Stop`` as visited.
    ///
    /// A stop is visited if the user has been near it.
    mutating func visited(_ stop: Stop) {
        guard let index = self.stops.firstIndex(where: { s in
            s.id == stop.id
        }) else { return }
        self.stops[index].visit()
    }
}



/// A data representation for a stop.
///
/// A stop in this context is a place of interest on the Campus. For example, the Library.
struct Stop: Identifiable, Equatable {
    var id: String { name }
    let name: String
    let description: String
    let emoji: String
    let sensorId: String
    let nextStopDirection: Float // Direction to the next stop in radians. 0 indicates the north and pi is south. Counter clock wise
    let imageName: String?
    var interestPoints: [InterestPoint] = []
    private(set) var completed: Bool = false
    private(set) var visited: Bool = false
    private(set) var isWaypoint: Bool = false // A waypoint is a stop that does not show extra information to the tour.
    
    /// Marks the stop as completed
    mutating func complete() {
        self.completed = true
    }
    
    
    /// Indicates that the user has visited the stop. Meaning that the sensors detected them at least one time in less than 1 meter from it.
    mutating func visit() {
        self.visited = true
    }
}


struct InterestPoint: Identifiable, Equatable {
    var id: String { name }
    let name: String
    let distance: Float
}
