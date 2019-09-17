import GTFS
import Foundation

struct TransitSystem: Codable {
    
    private let urls: [URL]
    var agency = Set<Agency>()
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
    var transfers = Set<Transfer>()
    var fareRules = Set<FareRules>()
    let feedId: String

    init(urls: [URL], feedId: String) {
        self.urls = urls
        self.feedId = feedId
        buildProperties()
        joinProperties()
    }

    private mutating func buildProperties() {
        filterAndBuild(name: .agency, type: Agency.self)
            .flatMap { agency.append(contentsOf: $0) }

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
        
        filterAndBuild(name: .transfers, type: Transfer.self)
            .flatMap { self.transfers.append(contentsOf: $0)}
        
        filterAndBuild(name: .fareRules, type: FareRules.self)
            .flatMap { self.fareRules.append(contentsOf: $0) }
    }

    private mutating func joinProperties() {
        
        let routeCache          = routes.toDict(key: \.id)
        let shapeCache          = shapes.toDict(key: \.shapeId)
        let calendarCache       = calendar.toDict(key: \.serviceId)
        let stopTimeCache       = stopTimes.toDict(key: \.tripId)
        let frequencyCache      = frequencies.toDict(key: \.tripId)
        let calendarDateCache   = calendarDates.toDict(key: \.serviceId)
        let fareRulesCache      = fareRules.toDict(key: \.routeId)
        let agencyCache         = agency.toDict(key: \.id)

        trips.mutatingMap { trip in
            trip.route       = routeCache[trip.routeId].flatMap { $0.first }
            trip.calendar    = calendarCache[trip.serviceId].flatMap { $0.first }
            
            trip.shapes = trip.shapeId
                .flatMap { shapeCache[$0] } ?? []
            
            let matchingCalendarDates = calendarDateCache[trip.serviceId] ?? []
            trip.calendar?.appendCalendarDate(matchingCalendarDates)
            trip.frequencies.append(contentsOf: frequencyCache[trip.id] ?? [])
            trip.stopTimes.append(contentsOf: stopTimeCache[trip.id] ?? [])
        }
        
        let stopCache = stops.toDict(key: \.id)
        let tripCache = trips.toDict(key: \.id)
        let tripServiceCache = trips.toDict(key: \.serviceId)
        
        stopTimes.mutatingMap { stopTime in
            stopTime.stop = stopCache[stopTime.stopId].flatMap { $0.first }
            stopTime.trip = tripCache[stopTime.tripId].flatMap { $0.first }
        }
        
        calendar.mutatingMap { calendar in
            tripServiceCache[calendar.serviceId]?.first
                .flatMap { trip in calendar.trip = trip }
        }
              
        transfers.mutatingMap { transfer in
            stopCache[transfer.toStopId]
                .flatMap { stops in transfer.toStop = stops.first }
            
            stopCache[transfer.fromStopId]
                .flatMap { stops in transfer.fromStop = stops.first }
        }
        
        let tripRouteIdCache = trips.toDict(key: \.routeId)
        
        routes.mutatingMap { route in
            route.agencyId
                .flatMap { agencyId in agencyCache[agencyId]?.first }
                .flatMap { agency in route.agency = agency }
            
            fareRulesCache[route.id]
                .flatMap { route.fareRules.append(contentsOf: $0) }
            
            tripRouteIdCache[route.id]
                .flatMap { trips in route.trips.append(contentsOf: trips) }
                
        }
        
        let routesAgencyIdCache = routes.toDict(key: \.agencyId)
        
        agency.mutatingMap { agency in
            routesAgencyIdCache[agency.id]
                .flatMap { routes in agency.routes.append(contentsOf: routes) }
        }
        
        frequencies.mutatingMap { frequency in
            tripCache[frequency.tripId]
                .flatMap { trip in frequency.trip = trip.first }
        }
        
        let fareRuleCache = fareRules.toDict(key: \.fareId)
        
        fareRules.mutatingMap { rule in
            fareRuleCache[rule.fareId]
                .flatMap { rules in rule.fareRules.append(contentsOf: rules) }
        }
    }

    func filterAndBuild<T: Codable>(name: GTFSFileName, type: T.Type) -> [T]? {
        return urls
            .first(where: { filterFiles(url: $0, fileName: name) })
            .flatMap { url in try? String(contentsOf: url, encoding: .utf8) }
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
        frequencies = "frequencies",
        transfers = "transfers"
    }
    
    private enum CodingKeys: String, CodingKey {
        case urls,
        agency,
        calendarDates,
        stopTimes,
        trips,
        stops,
        calendar,
        routes,
        shapes,
        fareAttributes,
        frequencies,
        transfers,
        fareRules,
        feedId
    }
}
