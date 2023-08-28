//  LocationsViewModel.swift

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject {
    
    // All loaded locations
    @Published var locations: [Location]
    
    // Current selected location on the map
    @Published var mapLocation: Location {
        // every time we se the value for mapLocation we're going to call updateMapRegion()
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    
    // We need to also create a region because the map is tied to a region
    // Map(coordinateRegion: $mapRegion)
    // We initialize mapRegion with a blank region
    // This is the current region on map
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    // Show location detail via Sheet
    @Published var sheetlocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        // self.locations is the the locations in line 9
        // locations is the the locations in line 6
        self.locations = locations
        self.mapLocation = locations.first!
        // We set the mapRegion to whatever the current region is
        self.updateMapRegion(location: locations.first!)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation(.easeInOut) {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
        
    }
    
    func toggleLocationsList() {
        withAnimation(.easeInOut) {
            showLocationsList = !showLocationsList
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationsList = false
        }
    }
    
    func nextButtonPressed() {
        
        // Get the current index
    //        let currentIndex = locations.firstIndex { location in
    //            return location == mapLocation
    //        }
            // shorter version of above
        guard let currentIndex = locations.firstIndex(where: {$0 == mapLocation}) else {
            print("Could not find current index in locations array!")
            return
        }
        
        // Check if the next index is valid
        // ie if we're at the last item of the array, then the next index would be out of bounds
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is NOT valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index IS valid
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
