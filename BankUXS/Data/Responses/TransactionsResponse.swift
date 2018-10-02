
import ObjectMapper

class TransactionsResponse: Mappable {
    var id: Int
    var date: String?
    var amount: Float
    var fee: Float?
    var description: String?
    
    init() {
        id = 0
        date = ""
        amount = 0.0
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        date <- map["date"]
        amount <- map["amount"]
        fee <- map["fee"]
        description <- map["description"]
    }
}
