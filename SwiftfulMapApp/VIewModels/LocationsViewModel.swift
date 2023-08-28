//  LocationsViewModel.swift

import Foundation

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    
    init() {
        let locations = LocationsDataService.locations
        // self.locations is the the locations in line 9
        // locations is the the locations in line 6
        self.locations = locations
    }
}
