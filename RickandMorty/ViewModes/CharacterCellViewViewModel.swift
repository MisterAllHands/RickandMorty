//
//  CharacterCellViewViewModel.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 18/08/2023.
//

import UIKit

final class CharacterCollectionCellViewModel {
    
   public let characterName: String
   public let characterStatus: CharacterStatus
   private let characterImageUrl: URL?
   
    // MARK: Init
    
    init(characterName: String,
         characterStatus: CharacterStatus,
         characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public func fetchImage(completion: @escaping(Result <Data,Error>) -> ()) {
        guard let url = characterImageUrl else {completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request){data, _, error in
            guard let data = data, error == nil else {completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
