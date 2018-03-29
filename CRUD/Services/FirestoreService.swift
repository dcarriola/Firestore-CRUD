//
//  FirestoreService.swift
//  CRUD
//
//  Created by Daniel Alejandro Carriola on 3/29/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestore

enum CollectionReferenceService: String {
    case users
}

class FirestoreService {
    // Singleton
    static let instance = FirestoreService()
    
    private init() {}
    
    func configure() {
        FirebaseApp.configure()
    }
    
    private func reference(to collection: CollectionReferenceService) -> CollectionReference {
        return Firestore.firestore().collection(collection.rawValue)
    }
    
    func create<T: Encodable>(for encodableObject: T, in collection: CollectionReferenceService) {
        do {
            let json = try encodableObject.toJSON(excluding: ["id"])
            reference(to: collection).addDocument(data: json)
        } catch {
            print(error)
        }
    }
    
    func read<T: Decodable>(from collection: CollectionReferenceService, returning objectType: T.Type, _ completion: @escaping (_ users: [T]) -> ()) {
        reference(to: collection).addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            do {
                var objects = [T]()
                for document in snapshot.documents {
                    let object = try document.decode(as: objectType.self)
                    objects.append(object)
                }
                completion(objects)
            } catch {
                print(error)
            }
        }
    }
    
    func update<T: Encodable & Identifiable>(for encodableObject: T, in collection: CollectionReferenceService) {
        do {
            let json = try encodableObject.toJSON(excluding: ["id"])
            guard let id = encodableObject.id else { throw EncodableError.encodingError }
            reference(to: collection).document(id).setData(json)
        } catch {
            print(error)
        }
    }
    
    func delete<T: Identifiable>(_ identifiableObject: T, in collection: CollectionReferenceService) {
        do {
            guard let id = identifiableObject.id else { throw EncodableError.encodingError }
            reference(to: collection).document(id).delete()
        } catch {
            print(error)
        }
    }
}

