import GTFS
import Foundation

struct TransitSystem {
    
    private let urls: [URL]
    var agency: Agency?
    var calendarDates = Set<CalendarDate>()
    var stopTimes = Set<StopTime>()
    var trips = Set<GTFS.Trip>()
    var stops = Set<Stop>()
    var calendar = Set<GTFSCalendar>()
    var routes = Set<Route>()
    let parser = Parser()
    var shapes = [Shape]()
    var fareAttributes = Set<FareAttributes>()
    var frequencies = Set<Frequencies>()

    init(urls: [URL]) {
        self.urls = urls
        buildProperties()
        joinProperties()
    }

    private mutating func buildProperties() {

        self.agency = filterAndBuild(name: .agency, type: Agency.self)?.first

        filterAndBuild(name: .calendarDates, type: CalendarDate.self)
            .flatMap { calendarDates.append(contentsOf: $0) }

        filterAndBuild(name: .stopTimes, type: StopTime.self)
            .flatMap { stopTimes.append(contentsOf: $0) }

        filterAndBuild(name: .trips, type: GTFS.Trip.self)
            .flatMap { self.trips.append(contentsOf: $0)}
        
        filterAndBuild(name: .stops, type: Stop.self)
            .flatMap { self.stops.append(contentsOf: $0) }
        
        filterAndBuild(name: .calendar, type: GTFSCalendar.self)
            .flatMap { self.calendar.append(contentsOf: $0)}
        
        filterAndBuild(name: .routes, type: Route.self)
            .flatMap { self.routes.append(contentsOf: $0) }
        
        filterAndBuild(name: .shapes, type: Shape.self)
            .flatMap { self.shapes.append(contentsOf: $0) }
        
        filterAndBuild(name: .frequencies, type: Frequencies.self)
            .flatMap{ self.frequencies.append(contentsOf: $0) }
    }

    private mutating func joinProperties() {
        trips.mutatingMap { trip in
            trip.stopTimes.append(contentsOf: stopTimes.filter { $0.tripId == trip.id  })
            trip.route          = routes.first { $0.id == trip.routeId }
            trip.shapes         = shapes.filter({ $0.shapeId == trip.shapeId })
            trip.calendar       = calendar.first(where: { $0.serviceId == trip.serviceId })
            trip.frequencies    = frequencies.filter { $0.tripId == trip.id }

            let matchingCalendarDates = calendarDates.filter { $0.serviceId == trip.serviceId }
            trip.calendar?.appendCalendarDate(matchingCalendarDates)
        }
        
        stopTimes.mutatingMap { stopTime in
            stopTime.stop = stops.first(where: { stopTime.stopId == $0.id })
            stopTime.trip = trips.first(where: { $0.id == stopTime.tripId })
        }
        
        routes.forEach { route in
            let matchingRoutes = routes.filter { $0.agencyId == agency?.id }
            agency?.routes.append(contentsOf: Array(matchingRoutes))
        }
        
        
    }
    
    private func generateDictionary<Key: Comparable, Value: Comparable>(store: KeyPath<LHSType, LHSValue>, compare: KeyPath<RHSType, RHSValue>, data: [LHSType]) -> [LHSValue: LHSType] {
        
        return data.reduce(into: [:]) { (result, value) in
            
        }
    }

    func filterAndBuild<T: Codable>(name: GTFSFileName, type: T.Type) -> [T]? {
        return urls
            .first(where: { filterFiles(url: $0, fileName: name) })
            .map { val in
                print(val)
                return val
            }
            .flatMap { url in try? String(contentsOf: url, encoding: .utf8) }
            .map { val in
                print(val)
                return val
            }
            .flatMap { text in try? parser.decodeFile(data: text, type: T.self) }
    }
    
    func filterFiles(url: URL, fileName: GTFSFileName) -> Bool {
        return url.lastPathComponent.split(separator: ".")[0] == fileName.rawValue
    }

    enum GTFSFileName: String {
        case
        fareAttributes = "fare_attributes",
        agency = "agency",
        fareRules = "fare_rules",
        calendarDates = "calendar_dates",
        stopTimes = "stop_times",
        shapes = "shapes",
        trips = "trips",
        stops = "stops",
        calendar = "calendar",
        routes = "routes",
        frequencies = "frequencies"
    }
}
