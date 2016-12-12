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
    
    func getPossibleMoves(at space: Space, for piece: Piece) -> Set<Space> {
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
        case .whiteKing, .blackKing:
            return space.adjacentSpaces.union(castleOptions.map { $0.king.to })
        }
    }
    
    static func getSpace(rank: Rank, file: File) -> Space {
        return file.spaces.filter { $0.rank.rawValue == rank.rawValue }.first!
    }

    func getSpaces(with color: Color?) -> [Space] {
        return data.filter { $0.value.color == color }.map { $0.key }
    }

    func getValidMoves() -> [Move] {
        let spaces = getSpaces(with: color)
        let opponentOccupiedSpaces = getSpaces(with: color.opposite)
        var validMoves = [Move]()
        
        let king = spaces.filter{ data[$0] == (color == .white ? Piece.whiteKing : Piece.blackKing) }.first
        guard let kingPosition = king else {
            return []
        }

        let moves = spaces.flatMap { space in getPossibleMoves(at: space, for: getPiece(at: space)!).map{ Move(from: space, to: $0) }}
        let checks = opponentOccupiedSpaces.flatMap { space in getPossibleMoves(at: space, for: getPiece(at: space)!).filter{ $0 == kingPosition }.map{ Move(from: space, to: $0) }}

        validMoves = moves.filter { isValidMove($0, checks: checks) }
        return validMoves
    }
    
    func isInCheck(checks: [Move]) -> Bool {
        guard checks.count > 0 else {
            return false
        }
        
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
    
    func isValidMove(_ move: Move, checks: [Move]) -> Bool {
        guard let piece = getPiece(at: move.from),
            isEmpty(at: move.to) || isOccupiedByOpponent(at: move.to, myColor: piece.color) else {
            return false
        }
        
        let board = copy() as! Board
        
        switch piece {
        case .blackPawn, .whitePawn:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            guard move.to == enPassant || (move.from.file == move.to.file && !isOccupiedByOpponent(at: move.to, myColor: piece.color)) else {
                return false
            }
            
            board.move(move)
            return !board.isInCheck(checks: checks)
            
        case .blackKnight, .whiteKnight:
            board.move(move)
            return !board.isInCheck(checks: checks)
            
        case .blackBishop, .whiteBishop:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            board.move(move)
            return !board.isInCheck(checks: checks)
            
        case .blackRook, .whiteRook:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            board.move(move)
            return !board.isInCheck(checks: checks)
            
        case .blackQueen, .whiteQueen:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            board.move(move)
            return !board.isInCheck(checks: checks)
            
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
            
            board.move(move)
            return !board.isInCheck(checks: checks)
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
        data[space] = piece
    }
}

func == (lhs: Space, rhs: Space) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

func ~=(lhs: Move, rhs: Move) -> Bool {
    return lhs.from ~= rhs.from && lhs.to ~= rhs.to
}
