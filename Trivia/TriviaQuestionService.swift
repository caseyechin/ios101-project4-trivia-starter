//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Casey Chin on 3/18/24.
//

import Foundation

class TriviaQuestionService {
    
    
    private static func parse(data: Data) -> [TriviaQuestion] {
        
        let jsonDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        
        
        let results = jsonDictionary["results"] as! [String: Any]
        
        let responseCode = results["response_code"] as! Int
    
            let category = results["category"] as! String
                
            let question = results["question"] as! String
                
            let correctAnswer = results["correctAnswer"] as! String
                
            let incorrectAnswers = results["incorrectAnswers"] as! [String]
                
            let type = results["type"] as! String
                
            let difficulty = results["difficulty"] as! String
        
        
        return [TriviaQuestion(category: category, question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers, type: type, difficulty: difficulty)]
    }
    
    static func fetchQuestions(amount: Int, completion: (([TriviaQuestion]) -> Void)? = nil) {
        
        let parameters = "amount=\(amount)"
        
        let url = URL(string: "https://opentdb.com/api.php?\(parameters)")!
        
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
                completion?(response.results)
            }
            
        }
            task.resume() // resume the task and fire the request
        
        
    }
    
    
}
