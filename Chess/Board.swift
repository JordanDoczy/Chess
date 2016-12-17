//
//  Board.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

struct Move {
    var from: Space
    var to: Space
    
    init(from: Space, to: Space) {
        self.from = from
        self.to = to
    }
}

class Board: NSCopying {
    
    static let spaces: [Space] = [.a1, .a2, .a3, .a4, .a5, .a6, .a7, .a8,
                                  .b1, .b2, .b3, .b4,. b5, .b6, .b7, .b8,
                                  .c1, .c2, .c3, .c4,. c5, .c6, .c7, .c8,
                                  .d1, .d2, .d3, .d4,. d5, .d6, .d7, .d8,
                                  .e1, .e2, .e3, .e4,. e5, .e6, .e7, .e8,
                                  .f1, .f2, .f3, .f4,. f5, .f6, .f7, .f8,
                                  .g1, .g2, .g3, .g4,. g5, .g6, .g7, .g8,
                                  .h1, .h2, .h3, .h4,. h5, .h6, .h7, .h8]
    
    var castleOptions = Set<CastleMoves>()
    var color:Color = .white
    var data = [Space: Piece]()
    var enPassant:Space?
    var halfMove: Int = 0
    var fullMove: Int = 0

    var test =  Array<Piece?>(repeating: nil, count: 64);
    
    var blackPawns: UInt64   = 0
    var blackKnights: UInt64 = 0
    var blackBishops: UInt64 = 0
    var blackRooks: UInt64   = 0
    var blackQueen: UInt64   = 0
    var blackKing: UInt64    = 0

    var whitePawns: UInt64   = 0
    var whiteKnights: UInt64 = 0
    var whiteBishops: UInt64 = 0
    var whiteRooks: UInt64   = 0
    var whiteQueen: UInt64   = 0
    var whiteKing: UInt64    = 0
    
    var blackPieces: UInt64 {
        return blackPawns + blackKnights + blackBishops + blackRooks + blackQueen + blackKing
    }
    
    var whitePieces: UInt64 {
        return whitePawns + whiteKnights + whiteBishops + whiteRooks + whiteQueen + whiteKing
    }
    
    init() {
        
    }
    
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
    
    func getKingPosition(with color: Color) -> Space? {
        return color == .white ? Space(rawValue: whiteKing) : Space(rawValue: blackKing)
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

    func getPiece(at space: Space) -> Piece? {
        
        if blackPawns & space.rawValue > 0 {
            return .blackPawn
        } else if blackKnights & space.rawValue > 0 {
            return .blackKnight
        } else if blackBishops & space.rawValue > 0 {
            return .blackBishop
        } else if blackRooks & space.rawValue > 0 {
            return .blackRook
        } else if blackQueen & space.rawValue > 0 {
            return .blackQueen
        } else if blackKing & space.rawValue > 0 {
            return .blackKing
        } else if whitePawns & space.rawValue > 0 {
            return .whitePawn
        } else if whiteKing & space.rawValue > 0 {
            return .whiteKing
        } else if whiteBishops & space.rawValue > 0 {
            return .whiteBishop
        } else if whiteRooks & space.rawValue > 0 {
            return .whiteRook
        } else if whiteQueen & space.rawValue > 0 {
            return .whiteQueen
        } else if whiteKing & space.rawValue > 0 {
            return .whiteKing
        }

        return nil
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
    
    func getPossibleMoves(at space: Space, for piece: Piece) -> Set<Space> {
        switch piece {
        case .whitePawn, .blackPawn:
            return Board.getPawnMoves(at: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            return space.knightMoves
        case .whiteBishop, .blackBishop:
            return Set(space.diagonals.flatMap { $0.spaces })
        case .whiteRook, .blackRook:
            return  space.rank.spaces.union(space.file.spaces)
        case .whiteQueen, .blackQueen:
            return Set(space.diagonals.flatMap { $0.spaces }).union(space.rank.spaces).union(space.file.spaces)
        case .whiteKing, .blackKing:
            return space.adjacentSpaces.union(castleOptions.map { $0.king.to })
        }
    }
    
    static func getSpace(rank: Rank, file: File) -> Space {
        return file.spaces.filter { $0.rank.rawValue == rank.rawValue }.first!
    }
    
    func getSpaces(with color: Color) -> [Space] {
        let pieces = color == .white ? whitePieces : blackPieces
        return []
        return Board.spaces.filter { pieces & $0.rawValue > 0 }
    }

    func getValidMoves() -> [Move] {
        
        let spaces = getSpaces(with: color)
        let kingPosition = getKingPosition(with: color)
        
        let moves = spaces.flatMap { space in getPossibleMoves(at: space, for: getPiece(at: space)!).map{ Move(from: space, to: $0) }}
        return []
        
        print(kingPosition)
        print(moves)
        
        //let checks = opponentOccupiedSpaces.flatMap { space in getPossibleMoves(at: space, for: getPiece(at: space)!).filter{ $0 == kingPosition }.map{ Move(from: space, to: $0) }}
        //return moves.filter { isValidMove($0, checks: checks) }
    }
    
    func isInCheck(checks: [Move]) -> Bool {
        return checks.filter { isValidMove($0, checks: []) }.count > 0
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
        return false
//        let origin = move.from < move.to ? move.from : move.to
//        let destination = origin == move.from ? move.to : move.from
//        
//        let spaces: Set<Space>
//        
//        if move.from.rank == move.to.rank {
//            spaces = move.from.rank.spaces
//        } else if move.from.file == move.to.file {
//            spaces = move.from.file.spaces
//        } else if let diagonal = move.from.diagonals.intersection(move.to.diagonals).first {
//            spaces = diagonal.spaces
//        } else {
//            return false
//        }
//        
//        let isClear = spaces
//            .filter {
//                $0.index > origin.index
//                    && $0.index < destination.index
//                    && !isEmpty(at: $0) }
//            .count == 0
//        
//        return isClear

    }
    
    func isPathClearBetween(from: Space, to: Space) -> Bool {
        return isPathClearBetween(Move(from: from, to: to))
    }
    
    public static var count = 0
    func isValidMove(_ move: Move, checks: [Move]) -> Bool {
        Board.count += 1
        guard let piece = getPiece(at: move.from), 
            isEmpty(at: move.to) || isOccupiedByOpponent(at: move.to, myColor: piece.color) else {
            return false
        }
        
        switch piece {
        case .blackPawn, .whitePawn:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            guard move.to == enPassant || (move.from.file == move.to.file && !isOccupiedByOpponent(at: move.to, myColor: piece.color)) else {
                return false
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }

            return true
        case .blackKnight, .whiteKnight:
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        case .blackBishop, .whiteBishop:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        case .blackRook, .whiteRook:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        case .blackQueen, .whiteQueen:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        case .blackKing, .whiteKing:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            if abs(move.from.file.rawValue - move.to.file.rawValue) == 2 {
                let rookMove:Move
                
                switch move.to.file {
                case .g:
                    rookMove = Move(from: Board.getSpace(rank: move.to.rank, file: .h),
                                    to: Board.getSpace(rank: move.to.rank, file: .f))
                case .c:
                    rookMove = Move(from: Board.getSpace(rank: move.to.rank, file: .a),
                                    to: Board.getSpace(rank: move.to.rank, file: .d))
                default: return false
                }
                
                if !isValidMove(rookMove, checks: checks) {
                    return false
                }
            }
            
            if (checks.count > 0) {
                let board = copy() as! Board
                board.move(move)
                return !board.isInCheck(checks: checks)
            }
            
            return true
        }
    }

    func move(_ move: Move) {
        
        func enPassantCapture(_ space: Space) {
            if space.rank == ._3 {
                setSpace(Board.getSpace(rank: ._4, file: space.file), to: nil)
            } else {
                setSpace(Board.getSpace(rank: ._7, file: space.file), to: nil)
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
                enPassant = move.to
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
        case .whiteKing, .blackKing:
            switch move {
            case CastleMoves.blackKingSide.king:
                self.move(CastleMoves.blackKingSide.rook)
            case CastleMoves.blackQueenSide.king:
                self.move(CastleMoves.blackQueenSide.rook)
            case CastleMoves.whiteKingSide.king:
                self.move(CastleMoves.whiteKingSide.rook)
            case CastleMoves.whiteQueenSide.king:
                self.move(CastleMoves.whiteQueenSide.rook)
            default:
                break
            }
            castleOptions.removeAll()
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
        if let piece = piece {
            switch (piece) {
            case .blackPawn:
                blackPawns += space.rawValue
            case .blackKnight:
                blackKnights += space.rawValue
            case .blackBishop:
                blackBishops += space.rawValue
            case .blackRook:
                blackRooks += space.rawValue
            case .blackQueen:
                blackQueen = space.rawValue
            case .blackKing:
                blackKing = space.rawValue
            case .whitePawn:
                whitePawns += space.rawValue
            case .whiteKnight:
                whiteKnights += space.rawValue
            case .whiteBishop:
                whiteBishops += space.rawValue
            case .whiteRook:
                whiteRooks += space.rawValue
            case .whiteQueen:
                whiteQueen = space.rawValue
            case .whiteKing:
                whiteKing = space.rawValue
            }
        } else {
            blackPawns   &= ~space.rawValue
            blackKnights &= ~space.rawValue
            blackBishops &= ~space.rawValue
            blackRooks   &= ~space.rawValue
            blackQueen   &= ~space.rawValue
            blackKing    &= ~space.rawValue
            whitePawns   &= ~space.rawValue
            whiteKnights &= ~space.rawValue
            whiteBishops &= ~space.rawValue
            whiteRooks   &= ~space.rawValue
            whiteQueen   &= ~space.rawValue
            whiteKing    &= ~space.rawValue
        }
    }
}

func == (lhs: Space, rhs: Space) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

func ~=(lhs: Move, rhs: Move) -> Bool {
    return lhs.from ~= rhs.from && lhs.to ~= rhs.to
}
