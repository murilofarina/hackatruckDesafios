import Foundation
//struct User: Codable, Identifiable, Hashable {
//    let id: String
//    let name: String
//    let isWorker: Bool
//    let occupation: String?
//    let category: String?
//    let hourValue: Double?
//    let bio: String?
//    let photo: String?
//    let state: String
//    let city: String
//    let latitude: Double
//    let longitude: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case name, isWorker, occupation, category, hourValue, bio, photo, state, city, latitude, longitude
//    }
//    
//  
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        id = try container.decode(String.self, forKey: .id)
//        name = try container.decode(String.self, forKey: .name)
//        isWorker = try container.decode(Bool.self, forKey: .isWorker)
//        occupation = try container.decodeIfPresent(String.self, forKey: .occupation)
//        category = try container.decodeIfPresent(String.self, forKey: .category)
//        bio = try container.decodeIfPresent(String.self, forKey: .bio)
//        photo = try container.decodeIfPresent(String.self, forKey: .photo)
//        state = try container.decode(String.self, forKey: .state)
//        city = try container.decode(String.self, forKey: .city)
//        latitude = try container.decode(Double.self, forKey: .latitude)
//        longitude = try container.decode(Double.self, forKey: .longitude)
//
//        if let hourValueString = try container.decodeIfPresent(String.self, forKey: .hourValue) {
//            hourValue = Double(hourValueString)
//        } else {
//            hourValue = nil
//        }
//    }
//}

struct User: Codable, Identifiable, Hashable {
    
    
    let id: String
    let name: String
    let isWorker: Bool
    let state: String
    let city: String
    let occupation: String?
    let category: String?
    let bio: String?
    let photo: String?
    let latitude: Double?
    let longitude: Double?
    let hourValue: Double?

    var hourValueFormatted: String {
        guard let value = hourValue, value > 0 else {
            return "Valor não informado"
        }
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        formatter.currencySymbol = "R$"
        
        return (formatter.string(from: NSNumber(value: value)) ?? "\(value)")
    }

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, isWorker, occupation, category, hourValue, bio, photo, state, city, latitude, longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
 
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        isWorker = try container.decode(Bool.self, forKey: .isWorker)
        state = try container.decode(String.self, forKey: .state)
        city = try container.decode(String.self, forKey: .city)
        occupation = try container.decodeIfPresent(String.self, forKey: .occupation)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        photo = try container.decodeIfPresent(String.self, forKey: .photo)
        latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
        longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)

        if let stringValue = try? container.decodeIfPresent(String.self, forKey: .hourValue) {
           
            self.hourValue = Double(stringValue.replacingOccurrences(of: ",", with: "."))
       
        } else if let doubleValue = try? container.decodeIfPresent(Double.self, forKey: .hourValue) {
            self.hourValue = doubleValue
       
        } else {
            self.hourValue = nil
        }
    }
    init(id: String, name: String, isWorker: Bool, state: String, city: String, occupation: String? = nil, category: String? = nil, bio: String? = nil, photo: String? = nil, latitude: Double? = nil, longitude: Double? = nil, hourValue: Double? = nil) {
        self.id = id
        self.name = name
        self.isWorker = isWorker
        self.state = state
        self.city = city
        self.occupation = occupation
        self.category = category
        self.bio = bio
        self.photo = photo
        self.latitude = latitude
        self.longitude = longitude
        self.hourValue = hourValue
    }
}



struct States: Codable, Hashable, Identifiable {

    let id: Int
    let sigla: String
    let nome: String

}
    
struct Cities: Codable, Hashable, Identifiable {

    let id: Int
    let nome: String

}

struct Contract: Codable, Identifiable {

    let id: String
    let clientId: String
    let providerId: String
    let timestamp: String
    let status: String
    

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case clientId
        case providerId
        case timestamp
        case status
    }
}
// Este struct representa os dados que enviamos para a API ao CRIAR um novo usuário.
// É mais simples que o struct 'User' completo.
struct NewUserPayload: Codable {
    let name: String
    let isWorker: Bool
    let occupation: String?
    let hourValue: Double?
    let bio: String?
    let photo: String?
    let state: String
    let city: String
    let category: String?
    // Note que não enviamos ID, latitude ou longitude. O servidor cuidará disso.
}
//struct Usermapa: Codable, Hashable {
//
//    let name: String?
//
//    let isWorker: Bool?
//
//    let occupation: String?
//
//    let hourValue: String?
//
//    let bio: String?
//
//    let photo: String?
//
//    let state: String?
//
//    let latitude: Double?
//
//    let longitude: Double?
//
//    let city: String?
//
//    let category: String?
//
//}
