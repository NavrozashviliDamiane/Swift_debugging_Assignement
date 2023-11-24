//onformance to Decodable Protocol: Both Article and News structs now conform to the Decodable protocol. This allows these structs to be decoded from JSON data using JSONDecoder.

import Foundation

struct News: Decodable {
    let authors: String?
    let title: String?
    let urlToImage: String?
}
