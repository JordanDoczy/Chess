//
//  Board.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

class Board {
    
    fileprivate var data = Array<Piece?>(repeating: nil, count: 64)
    
    func clearBoard() {
        data = Array<Piece?>(repeating: nil, count: 64)
    }
    
    func isEmpty(at space: Space) -> Bool {
        return getPiece(at: space) == nil
    }
    
    func isOccupiedByOpponent(at space: Space, myColor: Color) -> Bool {
        guard let piece = getPiece(at: space) else {
            return false
        }
        
        return piece.color != myColor
    }

    func getPiece(at space: Space) -> Piece? {
        return data[space.rawValue]
    }
    
    func getPieces(at diagonal: Diagonal) -> [Piece?] {
        let spaces = diagonal.spaces.sorted { $0.file.rawValue < $1.file.rawValue }
        return spaces.map{ getPiece(at: $0) }
    }
    
    func getPieces(at file: File) -> [Piece?] {
        let spaces = file.spaces.sorted { $0.rank.rawValue < $1.rank.rawValue }
        return spaces.map{ getPiece(at: $0) }
    }
    
    func getPieces(at rank: Rank) -> [Piece?] {
        let spaces = rank.spaces.sorted { $0.file.rawValue < $1.file.rawValue }
        return spaces.map{ getPiece(at: $0) }
    }
    
    func isPathClearBetween(from: Space, to: Space) -> Bool {
        
        let origin = from.rawValue < to.rawValue ? from : to
        let destination = origin == from ? to : from
        
        let spaces: Set<Space>
        
        if from.rank == to.rank {
            spaces = from.rank.spaces
        } else if from.file == to.file {
            spaces = from.file.spaces
        } else if let diagonal = from.diagonals.intersection(to.diagonals).first {
            spaces = diagonal.spaces
        } else {
            return false
        }
        
        let isClear = spaces
            .filter {
                $0.rawValue > origin.rawValue
                    && $0.rawValue < destination.rawValue
                    && !isEmpty(at: $0) }
            .count == 0
        
        return isClear
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
    
    func setBoard() {
        setSpace(.a1, to: .whiteRook)
        setSpace(.b1, to: .whiteKnight)
        setSpace(.c1, to: .whiteBishop)
        setSpace(.d1, to: .whiteQueen)
        setSpace(.e1, to: .whiteKing)
        setSpace(.f1, to: .whiteBishop)
        setSpace(.g1, to: .whiteKnight)
        setSpace(.h1, to: .whiteRook)
        setSpace(.a2, to: .whitePawn)
        setSpace(.b2, to: .whitePawn)
        setSpace(.c2, to: .whitePawn)
        setSpace(.d2, to: .whitePawn)
        setSpace(.e2, to: .whitePawn)
        setSpace(.f2, to: .whitePawn)
        setSpace(.g2, to: .whitePawn)
        setSpace(.h2, to: .whitePawn)
        
        setSpace(.a8, to: .blackRook)
        setSpace(.b8, to: .blackKnight)
        setSpace(.c8, to: .blackBishop)
        setSpace(.d8, to: .blackQueen)
        setSpace(.e8, to: .blackKing)
        setSpace(.f8, to: .blackBishop)
        setSpace(.g8, to: .blackKnight)
        setSpace(.h8, to: .blackRook)
        setSpace(.a7, to: .blackPawn)
        setSpace(.b7, to: .blackPawn)
        setSpace(.c7, to: .blackPawn)
        setSpace(.d7, to: .blackPawn)
        setSpace(.e7, to: .blackPawn)
        setSpace(.f7, to: .blackPawn)
        setSpace(.g7, to: .blackPawn)
        setSpace(.h7, to: .blackPawn)
    }
    
    func setSpace(_ space: Space, to piece: Piece?) {
        data[space.rawValue] = piece
    }
    
    
    
}
