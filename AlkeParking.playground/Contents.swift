import UIKit
import Foundation

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
    let maxVehicles: Int = 20
    
    func onFinished(_ accepted: Bool) {
        if accepted {
            print("Welcome to Alkeparking.")
        } else {
            print("Sorry, the check-in failed.")
        }
    }
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) {
        guard vehicles.count < maxVehicles else {
            onFinish(false)
            print("Numero maximo")
            return
        }
        
        if  vehicles.map ({ $0.plate}).contains(vehicle.plate) {
            print("plate existe")
            onFinish(false)
        } else {
            print("todo bien")
            onFinish(true)
        }
    }
    
}

// MARK: 2.2 - Vehicle.type is defined like a constant cause the type propertie no change.
struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    let checkInTime: Date
//    var checkOutTime: Date = Date()
    lazy var discountCard: String? = ""
    
       
    
    init(plate: String, type: VehicleType, checkInTime: Date, discountCard: String? ) {
        self.plate = plate
        self.type = type
        self.checkInTime = checkInTime
        self.discountCard = discountCard
    }
    
    var parkedTime: Int {
        self.carOut()
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

//alkeParking.vehicles.insert(car)
//alkeParking.vehicles.insert(moto)
//alkeParking.vehicles.insert(miniBus)
//alkeParking.vehicles.insert(bus)
//

//alkeParking.vehicles.insert(moto1)
//
//alkeParking.vehicles.remove(moto)


var alkeParking = Parking()


let vehicle19 = Vehicle(plate: "ZZQQ34P", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle16 = Vehicle(plate: "AA111PP", type: VehicleType.car, checkInTime: Date(), discountCard: "DISCOUNT_CARD_001")

let vehicle17 = Vehicle(plate: "B222PPP", type: VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle18 = Vehicle(plate: "CC333PP", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:
nil)

let vehicle20 = Vehicle(plate: "DD444DD", type: VehicleType.bus,
checkInTime: Date(), discountCard: "DISCOUNT_CARD_002")

let vehicle1 = Vehicle(plate: "AA111AA", type:
VehicleType.car, checkInTime: Date(), discountCard:
"DISCOUNT_CARD_001")

let vehicle2 = Vehicle(plate: "B222BBB", type:
VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle3 = Vehicle(plate: "CC333CC", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:
nil)

let vehicle4 = Vehicle(plate: "WW54WWW", type:
VehicleType.bus, checkInTime: Date(), discountCard:
"DISCOUNT_CARD_002")

let vehicle5 = Vehicle(plate: "AA111BB", type:
VehicleType.car, checkInTime: Date(), discountCard:
"DISCOUNT_CARD_003")

let vehicle6 = Vehicle(plate: "B222CCC", type:
  VehicleType.moto, checkInTime: Date(), discountCard:
"DISCOUNT_CARD_004")

let vehicle7 = Vehicle(plate: "CC333DD", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:
nil)

let vehicle8 = Vehicle(plate: "DD444EE", type:
VehicleType.bus, checkInTime: Date(), discountCard:
"DISCOUNT_CARD_005")

let vehicle9 = Vehicle(plate: "AA111CC", type:
VehicleType.car, checkInTime: Date(), discountCard: nil)

let vehicle10 = Vehicle(plate: "B222DDD", type:
VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle11 = Vehicle(plate: "CC333EE", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:
nil)

let vehicle12 = Vehicle(plate: "DD444GG", type:
VehicleType.bus, checkInTime: Date(), discountCard:
"DISCOUNT_CARD_006")

let vehicle13 = Vehicle(plate: "AA111DD", type:
VehicleType.car, checkInTime: Date(), discountCard:
"DISCOUNT_CARD_007")

let vehicle14 = Vehicle(plate: "B222EEE", type:
 VehicleType.moto, checkInTime: Date(), discountCard: nil)

let vehicle15 = Vehicle(plate: "CC333FF", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:
nil)

let vehicle21 = Vehicle(plate: "ZZZ78ZZ", type:
VehicleType.miniBus, checkInTime: Date(), discountCard:
nil)


let arrVehicles: [Vehicle] = [
    vehicle1,
    vehicle2,
    vehicle3,
    vehicle4,
    vehicle5,
    vehicle6,
    vehicle7,
    vehicle8,
    vehicle9,
    vehicle10,
    vehicle11,
    vehicle12,
    vehicle13,
    vehicle14,
    vehicle15,
    vehicle16,
    vehicle17,
    vehicle18,
    vehicle19,
    vehicle20,
    vehicle21
]

var count = 0
for vehicle in arrVehicles {
    count += 1
    print(count)
    alkeParking.checkInVehicle(vehicle, onFinish: alkeParking.onFinished(_:)) // TO DO
    alkeParking.vehicles.insert(vehicle)
}

print(alkeParking.vehicles.count)


//https://meet.google.com/mzw-jwhq-fwo
