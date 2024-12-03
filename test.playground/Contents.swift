//import Foundation
//
//struct UpdateAvailabilityInput: Content {
//    let isAvailableForCase: Bool
//}
//
//func updateTraineeAvailability(traineeID: UUID, isAvailableForCase: Bool, completion: @escaping (Result<Trainee_, Error>) -> Void) {
//    // 1. Construct the URL
//    let urlString = "http://localhost:8080/trainees/\(traineeID.uuidString)/availability"
//    guard let url = URL(string: urlString) else {
//        completion(.failure(NetworkError.invalidURL))
//        return
//    }
//    
//    // 2. Create the URLRequest
//    var request = URLRequest(url: url)
//    request.httpMethod = "PUT"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    
//    // 3. Encode the body
//    let updateData = UpdateAvailabilityInput(isAvailableForCase: isAvailableForCase)
//    do {
//        let encoder = JSONEncoder()
//        let jsonData = try encoder.encode(updateData)
//        request.httpBody = jsonData
//    } catch {
//        completion(.failure(error))
//        return
//    }
//    
//    // 4. Create the data task
//    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        // Handle errors
//        if let error = error {
//            completion(.failure(error))
//            return
//        }
//        
//        // Check the response
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            completion(.failure(NetworkError.invalidResponse))
//            return
//        }
//        
//        // Parse the data
//        guard let data = data else {
//            completion(.failure(NetworkError.noData))
//            return
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            let trainee = try decoder.decode(Trainee_.self, from: data)
//            completion(.success(trainee))
//        } catch {
//            completion(.failure(error))
//        }
//    }
//    
//    // 5. Start the task
//    task.resume()
//}
//
//updateTraineeAvailability(traineeID: UUID("076eee0e-04bf-413a-8dc1-5a52ed8ee7b7"), isAvailableForCase: true, completion){
//    switch result {
//        case .success(let updatedTrainee):
//            print("Trainee updated successfully:")
//            print("Name: \(updatedTrainee.firstName) \(updatedTrainee.lastName)")
//            print("isAvailableForCase: \(updatedTrainee.isAvailableForCase)")
//        case .failure(let error):
//            print("Error updating trainee:", error)
//        }
//}


import Foundation

func updateCaseLog(
    serverURL: String,
    trainee: Trainee_,
    completion: @escaping (Result<HTTPURLResponse, Error>) -> Void
) {
    guard let url = URL(string: "\(serverURL)trainees/\(trainee.id!.uuidString)") else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(trainee)
        request.httpBody = jsonData
    } catch {
        print("Failed to encode case log: \(error)")
        return
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
           
            return
        }

        if let httpResponse = response as? HTTPURLResponse {
            
        }
    }

    task.resume()
}


var t = Trainee_(id: UUID(uuidString: "076eee0e-04bf-413a-8dc1-5a52ed8ee7b7"), firstName: "David", lastName: "Doe", email: "john@doe.com", isAvailableForCase: true, photo: nil, currentAvg: nil)


updateCaseLog(serverURL: "http://localhost:8080/", trainee: t) { result in
    switch result {
    case .success(let response):
        print("Update succeeded with status code: \(response.statusCode)")
    case .failure(let error):
        print("Update failed: \(error.localizedDescription)")
    }
}

