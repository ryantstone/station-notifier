import Foundation

struct AddTripPoint: Action {
    let station: Station
    let tripPoint: TripPoint
    let stationList: [Station]
}
