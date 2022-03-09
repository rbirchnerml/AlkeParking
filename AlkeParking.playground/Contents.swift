import UIKit

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    
    
}

enum VehicleType {
    case car
    case moto
    case miniBus
    case bus
    
    var costo: Int {
        switch self {
        case .car:
            return 20
        case .moto:
            return 15
        case .miniBus:
            return 25
        case .bus:
            return 30
        }
    }
}

/* MARK: 1 - Set is used cause the vehicle plate must be unique.
   Additionally, Set have better performance about other collections like the Array.
   The time needed to access the element into the set is the same no matter the size of the collection
 */
struct Parking {
    var vehicles: Set<Vehicle> = []
}

// MARK: 2.2 - Vehicle.type is defined like a constant cause the type propertie no change.
struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    let checkInTime: Date
//    var checkOutTime: Date = Date()
    var discountCard: String? = nil
    
    
    init(plate: String, type: VehicleType, checkInTime: Date, discountCard: String ) {
        self.plate = plate
        self.type = type
        self.checkInTime = checkInTime
        self.discountCard = discountCard
    }
    
    func carOut()-> Int {
        let mins = Calendar.current.dateComponents([.minute], from:
        checkInTime, to: Date()).minute ?? 0
        return mins
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
    
    static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }
}





//var alkeParking = Parking()
//let car = Vehicle(plate: "AA111AA", type: VehicleType.car,
//checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")
//let moto = Vehicle(plate: "B222BBB", type:
//VehicleType.moto, checkInTime: Date(), discountCard: nil)
//let miniBus = Vehicle(plate: "CC333CC", type:
//VehicleType.miniBus, checkInTime: Date(), discountCard:
//nil)
//let bus = Vehicle(plate: "DD444DD", type: VehicleType.bus,
//checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")
//alkeParking.vehicles.insert(car)
//alkeParking.vehicles.insert(moto)
//alkeParking.vehicles.insert(miniBus)
//alkeParking.vehicles.insert(bus)
