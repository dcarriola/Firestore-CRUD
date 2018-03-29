//
//  Helper.swift
//  CRUD
//
//  Created by Daniel Alejandro Carriola on 3/29/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import Foundation
import FirebaseFirestore

enum EncodableError: Error {
    case encodingError
}

extension Encodable {
    func toJSON(excluding keys: [String] = [String]()) throws -> [String: Any] {
        let objectData = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: objectData, options: [])
        guard var json = jsonObject as? [String: Any] else { throw EncodableError.encodingError }
        
        for key in keys {
            json[key] = nil
        }
        return json
    }
}

extension DocumentSnapshot {
    func decode<T: Decodable>(as objectType: T.Type, includingId: Bool = true) throws -> T {
        var documentJson = data()
        if includingId {
            documentJson["id"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        return decodedObject
    }
}
