import Foundation

//conformance to Decodable Protocol: Both Article and News structs now conform to the Decodable protocol. This allows these structs to be decoded from JSON data using JSONDecoder.


struct Article: Decodable {
    let articles: [News]
}

