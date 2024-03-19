//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Casey Chin on 3/18/24.
//

import Foundation

class TriviaQuestionService {
    
    
    private static func parse(data: Data) -> TriviaQuestion {
        
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        let triv = jsonDictionary["triv"] as! [String: Any]
        
        let category = triv["category"] as! String
        
        let question = triv["question"] as! String
        
        let correctAnswer = triv["correctAnswer"] as! String
        
        let incorrectAnswers = triv["incorrectAnswers"] as! [String]
        
        return TriviaQuestion(category: category, question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
    }
    
    static func fetchQuestions(completion: ((TriviaQuestion) -> Void)? = nil) {
        
        let url = URL(string: "https://opentdb.com/api.php?amount=10")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                assertionFailure("Error: \(error!.localizedDescription)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                assertionFailure("Invalid response")
                return
            }
            guard let data = data, httpResponse.statusCode == 200 else {
                assertionFailure("Invalid response status code: \(httpResponse.statusCode)")
                return
            }
            // at this point, `data` contains the data received from the response
            
            let decoder = JSONDecoder()
            
            let response = try! decoder.decode(TriviaAPIResponse.self, from: data)
            DispatchQueue.main.async {
                completion?(response.triv)
            }
            
        }
            task.resume() // resume the task and fire the request
        
        
        
    }
    
    
}
