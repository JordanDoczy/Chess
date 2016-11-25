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
    
    func isSpaceEmpty(space: Space) -> Bool {
        return getPiece(at: space) == nil
    }
    
    func isSpaceOccupiedByOpponent(space: Space, myColor: Color) -> Bool {
        guard let piece = getPiece(at: space) else {
            return false
        }
        
        return piece.color != myColor
    }

    func getDiagonal(diagonal: Diagonal) -> [Piece?] {
        return diagonal.spaces.map{ getPiece(at: $0) }
    }

    func getFile(file: File) -> [Piece?] {
        return file.spaces.map{ getPiece(at: $0) }
    }

    func getPiece(at space: Space) -> Piece? {
        return data[space.rawValue]
    }
    
    func getRank(rank: Rank) -> [Piece?] {
        return rank.spaces.map{ getPiece(at: $0) }
    }
    
    func isPathClear(from: Space, to: Space) -> Bool {
        if from.rank == to.rank {
            print(from.rank)
            return true
        } else if from.file == to.file {
            if from.rank.rawValue < to.rank.rawValue {
                for rankIndex in from.rank.rawValue+1...to.rank.rawValue {
                    guard let rank = Rank(rawValue: rankIndex) else {
                        return false
                    }
                    
                    let space = BoardHelper.getSpace(rank: rank, file: from.file)
                    if !isSpaceEmpty(space: space) {
                        return false
                    }
                }
            }
            
            print(from.file)
            return true
        } else if let diagonal = from.diagonals.intersection(to.diagonals).first {
            print(diagonal)
            return true
        }
            
        return false
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
        print( getRank(rank: rank).map { $0?.description ?? "[]" } )
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
