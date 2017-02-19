//
//  Fen.swift
//  Chess
//
//  Created by Jordan Doczy on 11/28/16.
//  Copyright © 2016 Jordan Doczy. All rights reserved.
//

import Foundation

enum FenElements: Int {
    case board = 0
    case color = 1
    case castleOptions = 2
    case enPassant = 3
    case halfMove = 4
    case fullMove = 5
}

class Fen {
    
    static var StandardBoard:String = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1"
    static var cache = [String:Board]()
    static func createBoard() -> Board {
        return createBoard(from: StandardBoard)!
    }
    
    static func createBoard(from fen: String) -> Board? {

        guard cache[fen] == nil else {
            return cache[fen]
        }
        
        func createBoard(fen: String) -> Board {
            let board = Board()
            var rank: Rank = ._8
            let rows = fen.components(separatedBy: "/")
            for row in rows {
                var file: File = .a
                for character in row.characters {
                    if let piece = Piece(rawValue: String(character)) {
                        let space = Board.getSpace(rank: rank, file: file)
                        board.setSpace(space, to: piece)
                        file = file.nextFile
                    } else if let emptySpaces = Int(String(character)) {
                        file = File(rawValue: file.rawValue + emptySpaces) ?? .a
                    }
                    
                    if file == .a {
                        rank = rank.previousRank
                    }
                }
            }
            
            return board
        }
        
        func createCastleOptions(fen: String) -> Set<CastleMoves> {
            var castleOptions = Set<CastleMoves>()
            for castle in fen.characters {
                if let castleMove = CastleMoves(rawValue: String(castle)) {
                    castleOptions.insert(castleMove)
                }
            }
            
            return castleOptions
        }

        
        let parts = fen.components(separatedBy: " ")
        
        guard parts.count == 6 else {
            return nil
        }
        
        let board = createBoard(fen: parts[FenElements.board.rawValue])
        board.castleOptions = createCastleOptions(fen: parts[FenElements.castleOptions.rawValue])
        board.color = Color(rawValue: parts[FenElements.color.rawValue]) ?? .white
        //board.enPassant = Space(rawValue: parts[FenElements.enPassant.rawValue])
        board.halfMove = Int(parts[FenElements.halfMove.rawValue]) ?? 0
        board.fullMove = Int(parts[FenElements.fullMove.rawValue]) ?? 0
        
        cache[fen] = board
        return board
    }
    
//    static func getFen(from board: Board) -> String {
//        
//        func getFen(at rank: Rank) -> String {
//            let pieces = board.getPieces(at: rank)
//            var value = ""
//            var spaceCount = 0
//            
//            for piece in pieces {
//                if let piece = piece {
//                    if spaceCount > 0 {
//                        value += "\(spaceCount)"
//                    }
//                    value += piece.rawValue
//                    spaceCount = 0
//                } else {
//                    spaceCount += 1
//                }
//            }
//            
//            if spaceCount > 0 {
//                value += "\(spaceCount)"
//            }
//            
//            return value
//        }
//        
//        let castleMoves = board.castleOptions.map { $0.rawValue }
//        let castleOptions = castleMoves.count > 0 ? castleMoves.joined() : "-"
//        //let enPassant = board.enPassant? ?? "-"
//        
//        var value = getFen(at: ._8) + "/"
//        value += getFen(at: ._7) + "/"
//        value += getFen(at: ._6) + "/"
//        value += getFen(at: ._5) + "/"
//        value += getFen(at: ._4) + "/"
//        value += getFen(at: ._3) + "/"
//        value += getFen(at: ._2) + "/"
//        value += getFen(at: ._1)
//        value += " \(board.color.rawValue)"
//        value += " \(castleOptions)"
//        //value += " \(enPassant)"
//        value += " \(board.halfMove)"
//        value += " \(board.fullMove)"
//        
//        return value
//    }
}
