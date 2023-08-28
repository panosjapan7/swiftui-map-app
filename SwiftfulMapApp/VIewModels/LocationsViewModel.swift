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
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
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
}
