//
//  Board.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

class Board: NSCopying {
    
    private(set) var castleOptions = Set<CastleMoves>()
    private(set) var color:Color = .white
    private(set) var data = [Space: Piece]()
    private(set) var enPassant:Space?
    private(set) var halfMove: Int = 0
    private(set) var fullMove: Int = 0

    init(data: [Space: Piece], castleOptions: Set<CastleMoves>, color: Color, enPassant: Space?, halfMove: Int, fullMove: Int) {
        self.data = data
        self.enPassant = enPassant
        self.color = color
        self.castleOptions = castleOptions
        self.halfMove = halfMove
        self.fullMove = fullMove
    }
    
    func clear() {
        data = [:]
        color = .white
        castleOptions = Set<CastleMoves>()
        enPassant = nil
    }

    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board(data: data, castleOptions: castleOptions, color: color, enPassant: enPassant, halfMove: halfMove, fullMove: fullMove)
        return copy
    }
    
    func getKingPosition(for color: Color) -> Space? {
        let spaces = getSpaces(with: color)
        guard let kingPosition = (spaces.filter{ data[$0] == (color == .white ? Piece.whiteKing : Piece.blackKing) }.first) else {
            return nil
        }
        return kingPosition
    }
    
    static func getPawnMoves(at space: Space, color: Color) -> Set<Space> {
        let adjacentSpaces = space.adjacentSpaces
        var validSpaces = Set<Space>()
        
        switch color {
        case .black:
            validSpaces = Set(adjacentSpaces.filter { $0.rank.rawValue < space.rank.rawValue })
            if space.rank == ._7 {
                validSpaces.insert(Space(rank: ._5, file: space.file))
            }
        case .white:
            validSpaces = Set(adjacentSpaces.filter { $0.rank.rawValue > space.rank.rawValue })
            if space.rank == ._2 {
                validSpaces.insert(Space(rank: ._4, file: space.file))
            }
        }
        
        return validSpaces
    }

    func getPiece(at space: Space) -> Piece? {
        return data[space]
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
    
    func getPossibleSpaces(at space: Space) -> Set<Space>? {
        guard let piece = getPiece(at: space) else { return nil }
        
        switch piece {
        case .whitePawn, .blackPawn:
            return Board.getPawnMoves(at: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            return space.knightMoves
        case .whiteBishop, .blackBishop:
            return Set(space.diagonals.flatMap { $0.spaces })
        case .whiteRook, .blackRook:
            return space.rank.spaces.union(space.file.spaces)
        case .whiteQueen, .blackQueen:
            return Set(space.diagonals.flatMap { $0.spaces }).union(space.rank.spaces).union(space.file.spaces)
        case .whiteKing:
            return space.adjacentSpaces.union(castleOptions.map { $0.king.to }.filter { $0.rank == ._1 })
        case .blackKing:
            return space.adjacentSpaces.union(castleOptions.map { $0.king.to }.filter { $0.rank == ._8 })
        }
    }
    
    func getSpaces(with color: Color?) -> [Space] {
        return data.filter { $0.value.color == color }.map { $0.key }
    }

    func getValidMoves() -> [Move] {
        let spaces = getSpaces(with: color)
        return getValidMoves(for: spaces, with: color)
    }
    
    func getValidMoves(for space: Space) -> [Move] {
        guard let piece = getPiece(at: space) else { return [] }
        return getValidMoves(for: [space], with: piece.color)
    }
    
    func getValidMoves(for spaces: [Space], with color: Color) -> [Move] {
        validMoves.removeAll()
        var moves = [Move]()
        spaces.forEach { space in
            moves += getPossibleSpaces(at: space)!.compactMap {
                Move(from: space, to: $0)
            }
        }
        return moves.filter { isValidMove($0) }
    }

    func getPossibleChecks(for color: Color) -> [Move] {
        guard let kingPosition = getKingPosition(for: color) else {
            return []
        }
        
        var checks = [Move]()
        let opponentSpaces = getSpaces(with: color.opposite)
        opponentSpaces.forEach { space in
            guard getPossibleSpaces(at: space)?.contains(kingPosition) ?? false else {
                return
            }
            
            if isValidMove(Move(from: space, to: kingPosition)) {
                checks.append(Move(from: space, to: kingPosition))
            }
        }
        
        return checks
    }
    
    func isInCheck(color: Color) -> Bool {
        return getPossibleChecks(for: color).count > 0
    }

    func isEmpty(at space: Space) -> Bool {
        return getPiece(at: space) == nil
    }

    func isOccupiedByOpponent(at space: Space, myColor: Color) -> Bool {
        guard let piece = getPiece(at: space) else {
            return false
        }
        
        return myColor == .white ? piece.color == .black : piece.color == .white
    }
    
    func isPathClearBetween(_ move: Move) -> Bool {
        let origin = move.from.index < move.to.index ? move.from : move.to
        let destination = origin == move.from ? move.to : move.from
        
        let spaces: Set<Space>
        
        if move.from.rank == move.to.rank {
            spaces = move.from.rank.spaces
        } else if move.from.file == move.to.file {
            spaces = move.from.file.spaces
        } else if let diagonal = move.from.diagonals.intersection(move.to.diagonals).first {
            spaces = diagonal.spaces
        } else {
            return false
        }
        
        let isClear = spaces
            .filter {
                $0.index > origin.index
                    && $0.index < destination.index
                    && !isEmpty(at: $0) }
            .count == 0
        
        return isClear

    }
    
    func isPathClearBetween(from: Space, to: Space) -> Bool {
        return isPathClearBetween(Move(from: from, to: to))
    }
    
    var validMoves = [Move:Bool]()
    func isValidMove(_ move: Move) -> Bool {
        
        if validMoves.keys.contains(move) {
            return validMoves[move]!
        }
        
        guard let piece = getPiece(at: move.from),
            isEmpty(at: move.to) || isOccupiedByOpponent(at: move.to, myColor: piece.color) else {
                validMoves[move] = false
            return validMoves[move]!
        }
        
        let board = copy() as! Board
        
        switch piece {
        case .blackPawn, .whitePawn:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                validMoves[move] = false
                return validMoves[move]!
            }
            
            guard move.to == enPassant || (move.from.file == move.to.file && !isOccupiedByOpponent(at: move.to, myColor: piece.color)) else {
                validMoves[move] = false
                return validMoves[move]!
            }
            
            board.move(move)
            validMoves[move] = !board.isInCheck(color: color)
            return validMoves[move]!
            
        case .blackKnight, .whiteKnight:
            board.move(move)
            validMoves[move] = !board.isInCheck(color: color)
            return validMoves[move]!
            
        case .blackBishop, .whiteBishop, .blackRook, .whiteRook, .blackQueen, .whiteQueen:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                validMoves[move] = false
                return validMoves[move]!
            }
            
            board.move(move)
            validMoves[move] = !board.isInCheck(color: color)
            return validMoves[move]!
            
        case .blackKing, .whiteKing:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                validMoves[move] = false
                return validMoves[move]!
            }
            
            if abs(move.from.file.rawValue - move.to.file.rawValue) == 2 {
                let rookMove: Move
                
                switch move.to.file {
                case .g:
                    guard isValidMove(Move(from: move.from, to: Space(rank: move.to.rank, file: .f))) else {
                        validMoves[move] = false
                        return validMoves[move]!
                    }
                    
                    rookMove = Move(from: Space(rank: move.to.rank, file: .h),
                                    to: Space(rank: move.to.rank, file: .f))
                    
                case .c:
                    guard isValidMove(Move(from: move.from, to: Space(rank: move.to.rank, file: .d))) else {
                        validMoves[move] = false
                        return validMoves[move]!
                    }
                    
                    rookMove = Move(from: Space(rank: move.to.rank, file: .a),
                                    to: Space(rank: move.to.rank, file: .d))
                default: return false
                }
                
                if !isValidMove(rookMove) {
                    validMoves[move] = false
                    return validMoves[move]!
                }
            }
            
            board.move(move)
            validMoves[move] = !board.isInCheck(color: color)
            return validMoves[move]!
        }
    }

    func move(_ move: Move) {
        
        func enPassantCapture(_ space: Space) {
            if space.rank == ._3 {
                setSpace(Space(rank: ._4, file: space.file), to: nil)
            } else {
                setSpace(Space(rank: ._7, file: space.file), to: nil)
            }
        }

        guard let piece = getPiece(at: move.from) else {
            return
        }
        
        let currentEnPassant = enPassant
        
        enPassant = nil
        
        if !isEmpty(at: move.to) {
            halfMove = 0
        } else {
            halfMove += 1
        }
        
        switch piece {
        case .whitePawn, .blackPawn:
            if move.to == currentEnPassant {
                enPassantCapture(move.to)
            } else if abs(move.to.rank.rawValue - move.from.rank.rawValue) == 2 {
                switch piece.color {
                case .white: enPassant = Space(rank: move.to.rank.previousRank, file: move.to.file)
                case .black: enPassant = Space(rank: move.to.rank.nextRank, file: move.to.file)
                }
            }
            
            halfMove = 0
            
        case .whiteRook, .blackRook:
            switch move.from {
            case CastleMoves.blackKingSide.rook.from:
                castleOptions.remove(CastleMoves.blackKingSide)
            case CastleMoves.blackQueenSide.rook.to:
                castleOptions.remove(CastleMoves.blackQueenSide)
            case CastleMoves.whiteKingSide.rook.from:
                castleOptions.remove(CastleMoves.whiteKingSide)
            case CastleMoves.whiteQueenSide.rook.to:
                castleOptions.remove(CastleMoves.whiteQueenSide)
            default:
                break
            }
        case .blackKing:
            switch move {
            case CastleMoves.blackKingSide.king:
                self.move(CastleMoves.blackKingSide.rook)
            case CastleMoves.blackQueenSide.king:
                self.move(CastleMoves.blackQueenSide.rook)
            default:
                break
            }
            castleOptions = castleOptions.filter { $0.king.to.rank == ._1 }
        case .whiteKing:
            switch move {
            case CastleMoves.whiteKingSide.king:
                self.move(CastleMoves.whiteKingSide.rook)
            case CastleMoves.whiteQueenSide.king:
                self.move(CastleMoves.whiteQueenSide.rook)
            default:
                break
            }
            castleOptions = castleOptions.filter { $0.king.to.rank == ._8 }
        default:
            break
        }
        
        setSpace(move.to, to: piece)
        setSpace(move.from, to: nil)
        color = color.opposite
        
        if color == .white {
            fullMove += 1
        }
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
    
    func setSpace(_ space: Space, to piece: Piece?) {
        data[space] = piece
    }
}

func == (lhs: Space, rhs: Space) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

func ~=(lhs: Move, rhs: Move) -> Bool {
    return lhs.from ~= rhs.from && lhs.to ~= rhs.to
}
