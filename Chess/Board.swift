//
//  Board.swift
//  Chess
//
//  Created by Jordan Doczy on 11/20/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

class Board: ChessModel {
    
    static var STANDARD_BOARD:String = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    
    internal var color:Color = .white
    fileprivate var castleOptions = Set<CastleMoves>()
    internal var castleMoves: Set<Space> {
        return Set(castleOptions.map { $0.king.to })
    }
    fileprivate var data = [Space: Piece]()
    internal var enPassant:Space?
    
    convenience init() {
        self.init(fen: Board.STANDARD_BOARD)
    }
    
    init(fen: String) {
        createFromFen(fen: fen)
    }
    
    func clear() {
        data = [:]
        color = .white
        castleOptions = Set<CastleMoves>()
        enPassant = nil
    }
    
    fileprivate func createFromFen(fen: String) {
        let parts = fen.components(separatedBy: " ")
        
        guard parts.count == 6 else {
            return
        }
        
        color = Color(rawValue: parts[1]) ?? .white
        enPassant = Space(rawValue: parts[3])
        
        let castles = parts[2]
        for castle in castles.characters {
            if let castleMove = CastleMoves(rawValue: String(castle)) {
                castleOptions.insert(castleMove)
            }
        }
        
        var rank: Rank = ._8
        let rows = parts[0].components(separatedBy: "/")
        for row in rows {
            var file: File = .a
            for character in row.characters {
                if let piece = Piece(rawValue: String(character)) {
                    let space = Board.getSpace(rank: rank, file: file)
                    setSpace(space, to: piece)
                    file = file.nextFile
                } else if let emptySpaces = Int(String(character)) {
                    file = File(rawValue: file.rawValue + emptySpaces) ?? .a
                }
                
                if file == .a {
                    rank = rank.previousRank
                }
            }
        }
    }
    
    func getFen() -> String {
        let castleMoves = self.castleOptions.map { $0.rawValue }
        let castleOptions = castleMoves.count > 0 ? castleMoves.joined() : "-"
        let enPassant = self.enPassant?.rawValue ?? "-"
        
        var value = getFen(at: ._8) + "/"
        value += getFen(at: ._7) + "/"
        value += getFen(at: ._6) + "/"
        value += getFen(at: ._5) + "/"
        value += getFen(at: ._4) + "/"
        value += getFen(at: ._3) + "/"
        value += getFen(at: ._2) + "/"
        value += getFen(at: ._1)
        value += " \(color.rawValue)"
        value += " \(castleOptions)"
        value += " \(enPassant)"
        value += " 0"
        value += " 1"
        
        return value
    }
    
    fileprivate func getFen(at rank: Rank) -> String {
        let pieces = getPieces(at: rank)
        var value = ""
        var spaceCount = 0
        
        for piece in pieces {
            if let piece = piece {
                if spaceCount > 0 {
                    value += "\(spaceCount)"
                }
                value += piece.rawValue
                spaceCount = 0
            } else {
                spaceCount += 1
            }
        }
        
        if spaceCount > 0 {
            value += "\(spaceCount)"
        }

        return value
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
    
    func getSpaces(with color: Color?) -> [Space] {
        return data.filter { $0.value.color == color }.map { $0.key }
    }

    func isInCheck() -> Bool {
        let spaces = getSpaces(with: color.opposite).sorted { $0.index < $1.index }
        let king = data.filter { $0.value.rawValue == (color == .white ? Piece.whiteKing.rawValue : Piece.blackKing.rawValue) }
        
        guard let kingSpace = king.first?.key else {
            return false
        }

        let checks = spaces.filter { isValidMove(Move(from: $0, to: kingSpace), possibleMoves: nil, ignoreCheck: true) }
        return checks.count > 0
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
        
        switch piece {
        case .whitePawn, .blackPawn:
            if move.to == enPassant {
                enPassantCapture(move.to)
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
        default:
            break
        }
        
        setSpace(move.to, to: piece)
        setSpace(move.from, to: nil)
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
            return space.adjacentSpaces.union(castleMoves)
        }
    }
    
    func getValidMoves() -> [Move] {
        let spaces = getSpaces(with: color)
        var validMoves = [Move]()
        
        for space in spaces {
            if let piece = getPiece(at: space) {
                let moves = getPossibleMoves(at: space, for: piece)
                validMoves += moves.map { Move(from: space, to: $0) }.filter { isValidMove($0, possibleMoves: moves, ignoreCheck: false) }
            }
        }
        
        return validMoves
    }
    
    func isValidMove(_ move: Move, possibleMoves: Set<Space>?, ignoreCheck: Bool = false) -> Bool {
        guard let piece = getPiece(at: move.from) else {
            return false
        }
        
        guard let possibleMoves = possibleMoves else {
            return isValidMove(move, possibleMoves: getPossibleMoves(at: move.from, for: piece), ignoreCheck: ignoreCheck)
        }
        
        guard possibleMoves.contains(move.to), isEmpty(at: move.to) || isOccupiedByOpponent(at: move.to, myColor: piece.color) else {
            return false
        }

        let board = Board(fen: getFen())
        
        switch piece {
        case .blackPawn, .whitePawn:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            guard move.to == enPassant || (move.from.file == move.to.file && !isOccupiedByOpponent(at: move.to, myColor: piece.color)) else {
                return false
            }
            
            board.move(move)
            return ignoreCheck ? true : !board.isInCheck()
            
        case .blackKnight, .whiteKnight:
            board.move(move)
            return ignoreCheck ? true : !board.isInCheck()
            
        case .blackBishop, .whiteBishop:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            board.move(move)
            return ignoreCheck ? true : !board.isInCheck()
            
        case .blackRook, .whiteRook:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            board.move(move)
            return ignoreCheck ? true : !board.isInCheck()
            
        case .blackQueen, .whiteQueen:
            guard isPathClearBetween(from: move.from, to: move.to) else {
                return false
            }
            
            board.move(move)
            return ignoreCheck ? true : !board.isInCheck()
            
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
                
                if !isValidMove(rookMove, possibleMoves: nil, ignoreCheck: ignoreCheck) {
                    return false
                }
            }
            
            board.move(move)
            return ignoreCheck ? true : !board.isInCheck()
        }
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

    static func getBoardWithValidMoves(at space: Space, piece: Piece) -> Board {
        let board = Board()
        board.setSpace(space, to: piece)
        
        let spaces = board.getPossibleMoves(at: space, for: piece)
        for space in spaces {
            board.setSpace(space, to: piece)
        }
        
        return board
    }

    
}
