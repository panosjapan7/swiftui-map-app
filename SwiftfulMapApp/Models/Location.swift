//  Location.swift

import Foundation
import MapKit

struct Location: Identifiable, Equatable {
    let name: String
    let cityName: String
    let coordinates: CLLocationCoordinate2D
    let description: String
    let imageNames: [String]
    let link: String
    
    // We conformed to Identifiable by giving an id property to Location
    var id: String {
        // name = "Colloseum"
        // cityName = "Rome"
        // id = "ColloseumRome"
        name + cityName
    }
    
    // This is to make it Equatable
    // if one Location has the same id as another Location return true
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
}
