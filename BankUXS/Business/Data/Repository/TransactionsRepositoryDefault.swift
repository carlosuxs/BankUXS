
import Foundation
import Alamofire
import ObjectMapper

class TransactionsRepositoryDefault: TransactionsRepository {
    func getOperations(_ completion: @escaping ([TransactionsResponse]) -> ()) {
        Alamofire.request(Environment.apiBaseURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON {
            response in
            switch response.result {
            case .success:
                print(response)
                let transactionsResponse = Mapper<TransactionsResponse>().mapArray(JSONArray: response.result.value as! [[String : Any]])
                completion(transactionsResponse)
            case .failure(let error):
                
                print(error)            }
        }
    }
}
