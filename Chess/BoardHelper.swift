//
//  BoardHelper.swift
//  Chess
//
//  Created by Jordan Doczy on 11/25/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation


class BoardHelper {
    
    static func getBoardWithValidMoves(at space: Space, piece: Piece) -> Board {
        let board = Board()
        board.setSpace(space, to: piece)
        
        let spaces = getPossibleMoves(at: space, for: piece, castleMoves: nil)
        for space in spaces {
            board.setSpace(space, to: piece)
        }
        
        return board
    }

    static func getPawnMoves(at space: Space, color: Color) -> Set<Space> {
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
    
    static func getSpace(rank: Rank, file: File) -> Space {
        return file.spaces.filter { $0.rank.rawValue == rank.rawValue }.first!
    }
    
    static func getPossibleMoves(at space: Space, for piece: Piece, castleMoves: Set<Space>?) -> Set<Space> {
        switch piece {
        case .whitePawn, .blackPawn:
            return getPawnMoves(at: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            return space.knightMoves
        case .whiteBishop, .blackBishop:
            return Set(space.diagonals.flatMap { $0.spaces })
        case .whiteRook, .blackRook:
            return space.rank.spaces.union(space.file.spaces)
        case .whiteQueen, .blackQueen:
            return Set(space.diagonals.flatMap { $0.spaces }).union(space.rank.spaces).union(space.file.spaces)
        case .whiteKing, .blackKing:
            guard let castleMoves = castleMoves else {
                return space.adjacentSpaces
            }
            
            return space.adjacentSpaces.union(castleMoves)
        }
    }
    
    static func getValidMoves(model: ChessModel) -> [Move] {
        let spaces = model.getSpaces(with: model.color)
        var validMoves = [Move]()
        
        for space in spaces {
            if let piece = model.getPiece(at: space) {
                let moves = getPossibleMoves(at: space, for: piece, castleMoves: model.castleMoves)
                validMoves += moves.map { Move(from: space, to: $0) }.filter { isValidMove($0, with: model, possibleMoves: moves) }
            }
        }
        
        return validMoves
    }
    
    static func isInCheck() {
        
    }
    
    static func isValidMove(_ move: Move, with model: ChessModel, possibleMoves: Set<Space>?) -> Bool {
        
        guard let piece = model.getPiece(at: move.from) else {
            return false
        }
        
        guard let possibleMoves = possibleMoves else {
            return isValidMove(move, with: model, possibleMoves: getPossibleMoves(at: move.from, for: piece, castleMoves: model.castleMoves))
        }
        
        guard possibleMoves.contains(move.to), model.isEmpty(at: move.to) || model.isOccupiedByOpponent(at: move.to) else {
            return false
        }
        
        switch piece {
        case .blackPawn, .whitePawn:
            guard model.isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            guard move.to == model.enPassant || (move.from.file == move.to.file && !model.isOccupiedByOpponent(at: move.to)) else {
                return false
            }
            
            return true
            
        case .blackKnight, .whiteKnight:
            return true
            
        case .blackBishop, .whiteBishop:
            guard model.isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            return true
            
        case .blackRook, .whiteRook:
            guard model.isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            return true
            
        case .blackQueen, .whiteQueen:
            guard model.isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            return true
            
        case .blackKing, .whiteKing:
            guard model.isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if abs(move.from.file.rawValue - move.to.file.rawValue) == 2 {
                let rookMove:Move
                
                switch move.to.file {
                case .g:
                    rookMove = Move(from: BoardHelper.getSpace(rank: move.to.rank, file: .h),
                                    to: BoardHelper.getSpace(rank: move.to.rank, file: .f))
                case .c:
                    rookMove = Move(from: BoardHelper.getSpace(rank: move.to.rank, file: .a),
                                    to: BoardHelper.getSpace(rank: move.to.rank, file: .d))
                default: return false
                }
                
                if !isValidMove(rookMove, with: model, possibleMoves: nil) {
                    return false
                }
            }
            
            return true
        }
    }
}
