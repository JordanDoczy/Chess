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
    
    func isCheckmatePossible() -> Bool {
        
        var whiteCount = 0
        var blackCount = 0
        var result = false
        data.values.forEach { piece in
            switch(piece) {
            case .blackQueen, .whiteQueen, .blackRook, .whiteRook, .blackPawn, .whitePawn: result = true
            case .whiteBishop, .whiteKnight: whiteCount += 1
            case .blackBishop, .blackKnight: blackCount += 1
            default: break
            }
        }
        
        return result ? result : whiteCount > 1 || blackCount > 1
    }
    
    func isCheckmate() -> Bool {
        return getValidMoves().count == 0 && isInCheck(color: color)
    }
    
    func choosePiece(color: Color) -> Piece {
        return color == .white ? .whiteQueen : .blackQueen
    }
    
    func clear() {
        data = [:]
        color = .white
        castleOptions = Set<CastleMoves>()
        enPassant = nil
    }

    func computerMove() {
        var currentValue = getBoardValue()
        let validMoves = getValidMoves()
        
        var bestMove = validMoves.randomElement()!
        
        validMoves.forEach { move in
            let board = copy() as! Board
            board.move(move)
            
            let value = board.getBoardValue()
            
            let isWhite = color == .white
            if board.isCheckmate()
                || isWhite && value > currentValue
                || value < currentValue {
                bestMove = move
                currentValue = value
            }
        }
        
        move(bestMove)
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board(data: data, castleOptions: castleOptions, color: color, enPassant: enPassant, halfMove: halfMove, fullMove: fullMove)
        return copy
    }
    
    func getBoardValue() -> Float {
        return Float(data.values.map { $0.value }.reduce(0, { x, y in x+y }))
    }
    
    func getKingPosition(for color: Color) -> Space? {
        let spaces = getSpaces(with: color)
        guard let kingPosition = (spaces.filter{ data[$0] == (color == .white ? Piece.whiteKing : Piece.blackKing) }.first) else {
            return nil
        }
        return kingPosition
    }
    
    static func getPawnMoves(at space: Space, color: Color) -> Set<Space> {
        let adjacentSpaces = Spaces.getAdjacentSpaces(at: space)
        var validSpaces = Set<Space>()
        
        let rank = Spaces.getRank(at: space)
        let file = Spaces.getFile(at: space)
        
        switch color {
        case .black:
            validSpaces = Set(adjacentSpaces.filter { Spaces.getRank(at: $0).rawValue < rank.rawValue })
            if rank == ._7 {
                validSpaces.insert(Space(rank: ._5, file: file))
            }
        case .white:
            validSpaces = Set(adjacentSpaces.filter { Spaces.getRank(at: $0).rawValue > rank.rawValue })
            if rank == ._2 {
                validSpaces.insert(Space(rank: ._4, file: file))
            }
        }
        
        return validSpaces
    }

    func getPiece(at space: Space) -> Piece? {
        return data[space]
    }

// not used
//    func getPieces(at diagonal: Diagonal) -> [Piece?] {
//        let spaces = Diagonals.getSpaces(diagonal: diagonal).sorted {
//
//            $0.file.rawValue < $1.file.rawValue
//        }
//        return spaces.map{ getPiece(at: $0) }
//    }
//
//    func getPieces(at file: File) -> [Piece?] {
//        let spaces = file.spaces.sorted { $0.rank.rawValue < $1.rank.rawValue }
//        return spaces.map{ getPiece(at: $0) }
//    }
    
    func getPieces(at rank: Rank) -> [Piece?] {
        let spaces = Ranks.getSpaces(rank: rank).sorted {
            Spaces.getFile(at: $0).rawValue < Spaces.getFile(at: $1).rawValue
        }
        return spaces.map{ getPiece(at: $0) }
    }
    
    func getPossibleSpaces(at space: Space) -> Set<Space>? {
        guard let piece = getPiece(at: space) else { return nil }
        
        switch piece {
        case .whitePawn, .blackPawn:
            return Board.getPawnMoves(at: space, color: piece.color)
        case .whiteKnight, .blackKnight:
            return Spaces.getKnightMoves(at: space)
        case .whiteBishop, .blackBishop:
            return Spaces.getDiagnolSpaces(at: space)
        case .whiteRook, .blackRook:
            return Spaces.getRankSpaces(at: space).union(Spaces.getFileSpaces(at: space))
        case .whiteQueen, .blackQueen:
            return Spaces.getDiagnolSpaces(at: space).union(Spaces.getRankSpaces(at: space).union(Spaces.getFileSpaces(at: space)))
        case .whiteKing:
            return Spaces.getAdjacentSpaces(at: space).union(castleOptions.map { $0.king.to }.filter {
                Spaces.getRank(at: $0) == ._1 })
        case .blackKing:
            return Spaces.getAdjacentSpaces(at: space).union(castleOptions.map { $0.king.to }.filter {
                Spaces.getRank(at: $0) == ._8 })
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
        possibleChecks.removeAll()
        guard isCheckmatePossible() else { return [] }
        var moves = [Move]()
        spaces.forEach { space in
            moves += getPossibleSpaces(at: space)!.compactMap {
                Move(from: space, to: $0)
            }
        }
        return moves.filter { isValidMove($0) }
    }

    var possibleChecks = [Space: [Move]]()
    func getPossibleChecks(for color: Color) -> [Move] {
        guard let kingPosition = getKingPosition(for: color) else {
            return []
        }
        
        if let possibleChecks = possibleChecks[kingPosition] {
            return possibleChecks
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
        
        possibleChecks[kingPosition] = checks
        
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
        let origin = Spaces.getIndex(at: move.from) < Spaces.getIndex(at: move.to) ? move.from : move.to
        let destination = origin == move.from ? move.to : move.from
        
        let spaces: Set<Space>
        
        if Spaces.getRank(at: move.from) == Spaces.getRank(at: move.to) {
            spaces = Spaces.getRankSpaces(at: move.from)
        } else if Spaces.getFile(at: move.from) == Spaces.getFile(at: move.to) {
            spaces = Spaces.getFileSpaces(at: move.from)
        } else if let diagonal = Spaces.getDiagnols(at: move.from).intersection(Spaces.getDiagnols(at: move.to)).first {
            spaces = Diagonals.getSpaces(diagonal: diagonal)
        } else {
            return false
        }

        let originIndex = Spaces.getIndex(at: origin)
        let destinationIndex = Spaces.getIndex(at: destination)
        let isClear = spaces.filter { space in
            Spaces.getIndex(at: space) > originIndex
                && Spaces.getIndex(at: space) < destinationIndex
                && !isEmpty(at: space)
            }.count == 0

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
        
        let fromFile = Spaces.getFile(at: move.from)
        let toFile = Spaces.getFile(at: move.to)
        let toRank = Spaces.getRank(at: move.to)
        
        switch piece {
        case .blackPawn, .whitePawn:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                validMoves[move] = false
                return validMoves[move]!
            }

            guard move.to == enPassant
                || (fromFile != toFile && isOccupiedByOpponent(at: move.to, myColor: piece.color))
                || (fromFile == toFile && isEmpty(at: move.to)) else {
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
            
            if abs(fromFile.rawValue - toFile.rawValue) == 2 {
                let rookMove: Move
                
                switch toFile {
                case .g:
                    guard isValidMove(Move(from: move.from, to: Space(rank: toRank, file: .f))) else {
                        validMoves[move] = false
                        return validMoves[move]!
                    }
                    
                    rookMove = Move(from: Space(rank: toRank, file: .h),
                                    to: Space(rank: toRank, file: .f))
                    
                case .c:
                    guard isValidMove(Move(from: move.from, to: Space(rank: toRank, file: .d))) else {
                        validMoves[move] = false
                        return validMoves[move]!
                    }
                    
                    rookMove = Move(from: Space(rank: toRank, file: .a),
                                    to: Space(rank: toRank, file: .d))
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
            let rank = Spaces.getRank(at: space)
            let file = Spaces.getFile(at: space)
            if rank == ._3 {
                setSpace(Space(rank: ._4, file: file), to: nil)
            } else {
                setSpace(Space(rank: ._7, file: file), to: nil)
            }
        }

        guard var piece = getPiece(at: move.from) else {
            return
        }
        
        let currentEnPassant = enPassant
        
        enPassant = nil
        
        if !isEmpty(at: move.to) {
            halfMove = 0
        } else {
            halfMove += 1
        }
        
        let toFile = Spaces.getFile(at: move.to)
        
        switch piece {
        case .whitePawn, .blackPawn:
            let toRank = Spaces.getRank(at: move.to)
            let fromRank = Spaces.getRank(at: move.from)
            
            if move.to == currentEnPassant {
                enPassantCapture(move.to)
            } else if abs(toRank.rawValue - fromRank.rawValue) == 2 {
                switch piece.color {
                case .white: enPassant = Space(rank: toRank.previousRank, file: toFile)
                case .black: enPassant = Space(rank: toRank.nextRank, file: toFile)
                }
            } else if toRank == ._1 || toRank == ._8 {
                piece = choosePiece(color: color)
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
            castleOptions = castleOptions.filter { Spaces.getRank(at: $0.king.to) == ._1 }
        case .whiteKing:
            switch move {
            case CastleMoves.whiteKingSide.king:
                self.move(CastleMoves.whiteKingSide.rook)
            case CastleMoves.whiteQueenSide.king:
                self.move(CastleMoves.whiteQueenSide.rook)
            default:
                break
            }
            castleOptions = castleOptions.filter { Spaces.getRank(at: $0.king.to) == ._8 }
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
