//
//  BoardHelper.swift
//  Chess
//
//  Created by Jordan Doczy on 11/25/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

class BoardHelper {
    
    static func getSpace(rank: Rank, file: File) -> Space {
        return file.spaces.filter { $0.rank.rawValue == rank.rawValue }.first!
//        [rank.rawValue-1]
    }
    
    static func getValidKingMoves(at space: Space, color: Color) -> Set<Space> {
        
        let adjacentMoves = space.adjacentSpaces
        
        guard space == .e8 && color == .black || space == .e1 && color == .white else {
            return adjacentMoves
        }
        
        switch color {
        case .black: return adjacentMoves.union([.c8,.g8])
        case.white: return adjacentMoves.union([.c1,.g1])
        }
    }
    
    static func getValidMoves(at space: Space, piece: Piece) -> Set<Space> {
        var spaces = Set<Space>()
        
        switch piece {
        case .whitePawn, .blackPawn:
            spaces = getValidPawnMoves(at: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            spaces = space.knightMoves
        case .whiteBishop, .blackBishop:
            spaces = Set(space.diagonals.flatMap { $0.spaces })
        case .whiteRook, .blackRook:
            spaces = space.rank.spaces.union(space.file.spaces)
        case .whiteQueen, .blackQueen:
            spaces = Set(space.diagonals.flatMap { $0.spaces }).union(space.rank.spaces).union(space.file.spaces)
        case .whiteKing, .blackKing:
            spaces = getValidKingMoves(at: space, color: piece.color)
        }
        
        return spaces
    }
    
    static func getValidPawnMoves(at space: Space, color: Color) -> Set<Space> {
        let adjacentSpaces = space.adjacentSpaces
        var validSpaces = Set<Space>()
        
        switch color {
        case .black:
            validSpaces = Set(adjacentSpaces.filter { $0.rank.rawValue < space.rank.rawValue })
            if space.rank == ._7 {
                validSpaces.insert(getSpace(rank: ._5, file: space.file))
            }
        case .white:
            validSpaces = Set(adjacentSpaces.filter { $0.rank.rawValue > space.rank.rawValue })
            if space.rank == ._2 {
                validSpaces.insert(getSpace(rank: ._4, file: space.file))
            }
        }
        
        return validSpaces
    }
    
    static func getBoardWithValidMoves(at space: Space, piece: Piece) -> Board {
        let board = Board()
        board.setSpace(space, to: piece)
        
        let spaces = getValidMoves(at: space, piece: piece)
        for space in spaces {
            board.setSpace(space, to: piece)
        }
        
        return board
    }
}
