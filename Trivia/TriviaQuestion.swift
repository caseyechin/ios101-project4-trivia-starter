//
//  TriviaQuestion.swift
//  Trivia
//
//  Created by Mari Batilando on 4/6/23.
//

import Foundation
import UIKit

struct TriviaAPIResponse: Decodable {
    let responseCode: Int
  let results: [TriviaQuestion]

  private enum CodingKeys: String, CodingKey {
    case responseCode = "response_code"
      case results = "results"
  }
}

struct TriviaQuestion: Decodable {
    
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    let type: String
    let difficulty: String

    private enum CodingKeys: String, CodingKey {
        
        case category = "category"
        case question = "question"
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
        case type = "type"
        case difficulty = "difficulty"
        
      }
}




