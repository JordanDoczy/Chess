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
        return file.spaces[rank.rawValue-1]
    }
    
    static func getValidKingMoves(at space: Space, color: Color) -> [Space] {
        
        let adjacentMoves = space.adjacentSpaces
        
        guard space == .e8 && color == .black || space == .e1 && color == .white else {
            return adjacentMoves
        }
        
        switch color {
        case .black: return adjacentMoves + [.c8,.g8]
        case.white: return adjacentMoves + [.c1,.g1]
        }
    }
    
    static func getValidMoves(at space: Space, piece: Piece) -> [Space] {
        var spaces = [Space]()
        
        switch piece {
        case .whitePawn, .blackPawn:
            spaces = getValidPawnMoves(at: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            spaces = space.knightMoves
        case .whiteBishop, .blackBishop:
            spaces = space.diagonals.flatMap { $0.spaces }
        case .whiteRook, .blackRook:
            spaces = space.rank.spaces + space.file.spaces
        case .whiteQueen, .blackQueen:
            spaces = space.diagonals.flatMap { $0.spaces } + space.rank.spaces + space.file.spaces
        case .whiteKing, .blackKing:
            spaces = getValidKingMoves(at: space, color: piece.color)
        }
        
        return spaces
    }
    
    static func getValidPawnMoves(at space: Space, color: Color) -> [Space] {
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
