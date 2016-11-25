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
    
    func getSpace(rank: Rank, file: File) -> Space {
        return file.spaces[rank.rawValue-1]
    }
    
    func getValidKingMoves(space: Space, color: Color) -> [Space] {
        
        let adjacentMoves = space.adjacentSpaces
        
        guard space == .e8 && color == .black || space == .e1 && color == .white else {
            return adjacentMoves
        }
        
        switch color {
        case .black: return adjacentMoves + [.c8,.g8]
        case.white: return adjacentMoves + [.c1,.g1]
        }
    }
    
    func getValidMoves(space: Space, piece: Piece) -> [Space] {
        var spaces = [Space]()
        
        switch piece {
        case .whitePawn, .blackPawn:
            spaces = getValidPawnMoves(space: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            spaces = space.knightMoves
        case .whiteBishop, .blackBishop:
            spaces = space.diagonals.flatMap { $0.spaces }
        case .whiteRook, .blackRook:
            spaces = space.rank.spaces + space.file.spaces
        case .whiteQueen, .blackQueen:
            spaces = space.diagonals.flatMap { $0.spaces } + space.rank.spaces + space.file.spaces
        case .whiteKing, .blackKing:
            spaces = getValidKingMoves(space: space, color: piece.color)
        }
        
        return spaces
    }

    func getValidPawnMoves(space: Space, color: Color) -> [Space] {
        let adjacentSpaces = space.adjacentSpaces
        var validSpaces = [Space]()
        
        switch color {
        case .black:
            validSpaces = adjacentSpaces.filter { $0.rank.rawValue < space.rank.rawValue }
            if space.rank == ._7 {
                validSpaces.append(getSpace(rank: ._5, file: space.file))
            }
        case .white:
            validSpaces = adjacentSpaces.filter { $0.rank.rawValue > space.rank.rawValue }
            if space.rank == ._2 {
                validSpaces.append(getSpace(rank: ._4, file: space.file))
            }
        }
        
        return validSpaces
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
    
    func setSpace(_ space: Space, to piece: Piece) {
        data[space.rawValue] = piece
    }
    
    func testMoves(space: Space, piece: Piece) {
        clearBoard()
        setSpace(space, to: piece)

        let spaces = getValidMoves(space: space, piece: piece)
        for space in spaces {
            setSpace(space, to: piece)
        }
    }
    
}
