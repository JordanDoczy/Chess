//
//  Protocols.swift
//  Chess
//
//  Created by Jordan Doczy on 11/27/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

protocol ChessModel {
    var castleMoves: Set<Space> {
        get
    }
    var color: Color {
        get
    }
    
    var enPassant: Space? {
        get
    }
    func getPiece(at space: Space) -> Piece?
    func getPieces(at diagonal: Diagonal) -> [Piece?]
    func getPieces(at rank: Rank) -> [Piece?]
    func getPieces(at file: File) -> [Piece?]
    func getSpaces(with color: Color?) -> [Space]
    
    func isEmpty(at space: Space) -> Bool
    func isInCheck() -> Bool
    func isOccupiedByOpponent(at space: Space) -> Bool
    func isPathClearBetween(_ move: Move) -> Bool
    
    func move(_ move: Move)
    func setSpace(_ space: Space, to piece: Piece?)
}
