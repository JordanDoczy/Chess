//
//  Board2.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

typealias Move2 = (from: Int, to: Int)

class Board2 {
    
    private(set) var castleOptions = Set<CastleMoves>()
    private(set) var whitePieceLocations = Set<Int>()
    private(set) var blackPieceLocations = Set<Int>()
    private(set) var color: Color = .white
    private(set) var spaces = ArrayModel() // [Space: Piece]()
    private(set) var enPassant: Int?
    private(set) var halfMove: Int = 0
    private(set) var fullMove: Int = 0
    
    init(spaces: ArrayModel, castleOptions: Set<CastleMoves>, color: Color, enPassant: Int?, halfMove: Int, fullMove: Int) {
        self.enPassant = enPassant
        self.color = color
        self.castleOptions = castleOptions
        self.halfMove = halfMove
        self.fullMove = fullMove
        
        for space in spaces.model.indices {
            setSpace(at: space, to: spaces[space])
        }
    }
    
    func getPiece(at index: Int) -> Piece? {
        return spaces[index]
    }
    
    func getPieces(at rank: Rank) -> [Piece?] {
        let spaces = Ranks()[rank].sorted {
            Constants.squaresNormalized[$0].file.rawValue < Constants.squaresNormalized[$1].file.rawValue
        }
        return spaces.map{ getPiece(at: $0.rawValue) }
    }
    
    func printBoard() {
        printRank(rank: ._8)
        printRank(rank: ._7)
        printRank(rank: ._6)
        printRank(rank: ._5)
        printRank(rank: ._4)
        printRank(rank: ._3)
        printRank(rank: ._2)
        printRank(rank: ._1)
    }
    
    func printRank(rank: Rank) {
        print( getPieces(at: rank).map { $0?.description ?? "[]" })
    }
    
    func setSpace(at index: Int, to piece: Piece?) {
        if let color = piece?.color {
            switch color {
            case .white:
                whitePieceLocations.insert(index)
            case .black:
                blackPieceLocations.insert(index)
            }
        } else {
            whitePieceLocations.remove(index)
            blackPieceLocations.remove(index)
        }
        
        spaces[index] = piece
        
    }
}
