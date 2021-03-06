import UIKit
import Foundation

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    
    static func checkOutVehicle(_ plate: String, onSuccess: (Int) -> Void, onError: () -> Void)
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
    var earnings: (earnings: Int, vehicles: Int) = (0, 0)
    
    func onFinished(_ accepted: Bool) {
        if accepted {
            print("Welcome to Alkeparking.")
        } else {
            print("Sorry, the check-in failed.")
        }
    }
//    MARK: Ejercicio 6
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void) {
        guard vehicles.count < maxVehicles else {
            onFinish(false)
            print("No more parking spaces left. Sorry!")
            return
        }
        
        if  validatePlate(vehicle.plate) {
            onFinish(false)
        } else {
            self.vehicles.insert(vehicle)
            onFinish(true)
        }
    }
    
    mutating func acumulateEarnings(_ valor: Int) -> Void {
        earnings.earnings += valor
        earnings.vehicles += 1
    }
    
    func listVehicles() {
        vehicles.map({print($0.plate)})
    }
    
    func showResults() {
        print("\(earnings.1) vehicles have checked out and have earnings of $\(earnings.0)")
    }
    
    func validatePlate(_ plate: String) -> Bool  {
        self.vehicles.map ({ $0.plate}).contains(plate)
    }
    
    mutating func getVehicle(_ plate: String) -> Vehicle? {
        if validatePlate(plate) {
            let vehicleToLeave = vehicles.first(where: { $0.plate == plate } )
            if let vehicle = vehicleToLeave  { return vehicle }
            
        }
        return nil
    }
    
    mutating func removeVehicle(_ vehicle: Vehicle) {
        self.vehicles.remove(vehicle)
    }
    
}

// MARK: 2.2 - Vehicle.type is defined like a constant cause the type propertie no change.
struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    let checkInTime: Date
    var discountCard: String? = ""
        
    init(plate: String, type: VehicleType, checkInTime: Date, discountCard: String? ) {
        self.plate = plate
        self.type = type
        self.checkInTime = checkInTime
        self.discountCard = discountCard
    }
    
    var parkedTime: Int {
//        self.carOut()    // For production uncomment this line and comment or clear the next line.
        138     // Value hardcoded for testing purposes.
    }
    
    func carOut()-> Int {
        let mins = Calendar.current.dateComponents([.minute], from:
        checkInTime, to: Date()).minute ?? 0
        return mins
    }
    
    func calculateFee() -> Int {
        var fee: Double
        
        if parkedTime <= 120 {
            return self.type.costo * self.parkedTime
        } else {
            let timeLeft = (parkedTime - 120)/15
            let timeLeft2 = (parkedTime - 120)%15
            fee = timeLeft2 != 0 ? Double(self.type.costo + ((timeLeft + 1) * 5)) : Double(self.type.costo + (timeLeft * 5))
        }
        
        if let _ = discountCard {
            fee = fee * 0.85
        }
        
        return Int(fee)
    }
    
    static func checkOutVehicle(_ plate: String, onSuccess: (Int) -> Void, onError: () -> Void) {
        
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate)
    }
    
    static func ==(lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }
}

// MARK: Methods for checkOutVehicle like arguments
func onSuccess(_ valor: Int) {
    print("Your fee is \(valor). Come back soon!")
}

func onError() -> Void {
    print("Sorry, the check-out failed")
}

// MARK: Instances of Parking and Vehicules
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

for vehicle in arrVehicles {
    alkeParking.checkInVehicle(vehicle, onFinish: alkeParking.onFinished(_:))
}

// Show how many vehicles are in the parking lote.
print(alkeParking.vehicles.count)

// MARK: Exercise 10 - CheckOut.
let vehicleOut = alkeParking.getVehicle("DD444GG")

if let bus1 = vehicleOut {
    let fee: Int = bus1.calculateFee()
    Vehicle.checkOutVehicle(bus1.plate, onSuccess: onSuccess(_:), onError: { onError() })
    onSuccess(fee)
    alkeParking.removeVehicle(bus1)
    alkeParking.acumulateEarnings(fee)
}

// MARK: Exercise 11 - Show earnings
alkeParking.showResults()

// MARK: Exercise 12 - List Vehicles.
alkeParking.listVehicles()

// Show how many vehicles left in the parking lote
print(alkeParking.vehicles.count)


//https://meet.google.com/mzw-jwhq-fwo
