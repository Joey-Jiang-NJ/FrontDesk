import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

struct Case_: Identifiable ,Codable {
    var id: UUID?
    var caseType: String
    var patientInfo: String?
    var symptom: String?
    var diagnosis: String?
    var trainees: [Trainee_]?
    var faculties: [Faculty_]?
}

struct Faculty_: Identifiable ,Codable {
    var id: UUID?
    var firstName: String
    var lastName: String
    var email: String
    var preferences: [String: String]?
    var caseID: UUID?
}


struct Trainee_: Identifiable ,Codable {
    var id: UUID?
    var firstName: String
    var lastName: String
    var email: String
    var isAvailableForCase: Bool
    var photo: String?
    var currentAvg: Double?
    var evalNum: Int?
    var rotations: [Rotation_]?
    var caseID: UUID?
}

struct Rotation_: Identifiable, Codable {
    var id: UUID?
    var rotationName: String
    var startDate: String // Or Date if you handle date parsing
    var endDate: String   // Or Date if you handle date parsing
    var directorName: String
    var traineeID: UUID
    var createdAt: String?
    var updatedAt: String?
}

func traineeTrans(_ t: Trainee_) -> Trainee {
    let r = Trainee()
    r.traineeID = t.id!.uuidString
    r.firstName = t.firstName
    r.lastName = t.lastName
    r.emailAddress = t.email
    r.isAvailableForCase = t.isAvailableForCase
    r.picture = t.photo!
    r.rotationID = ""
    r.evalScore = t.currentAvg!
    r.evalCount = t.evalNum!
    return r
}

func traineeTrans2(_ t: Trainee) -> Trainee_ {
    let t = Trainee_(id: UUID(uuidString: t.traineeID), firstName: t.firstName, lastName: t.lastName, email: t.emailAddress, isAvailableForCase: t.isAvailableForCase, photo: nil, currentAvg: nil, caseID: UUID(uuidString: t.caseID))
    return t
}

func facultyTrans(_ f: Faculty_) -> Faculty {
    let r = Faculty()
    r.id = f.id!.uuidString
    if f.preferences != nil {
        r.preferences = f.preferences!
    }
    r.fName = f.firstName
    r.lName = f.lastName
    r.caseID = f.caseID!.uuidString
    return r
}

func caseTrans(_ c: Case_) -> Case {
    let r = Case()
    r.id = c.id!.uuidString
    r.type = c.caseType
    r.patientInfo = c.patientInfo!
    if c.faculties != nil{
        for f in c.faculties! {
            r.facultyList.append(facultyTrans(f))
        }
    }
    
    if c.trainees != nil{
        for t in c.trainees! {
            r.traineeList.append(traineeTrans(t))
        }
    }
    r.diagnosis = c.diagnosis!
    r.symptoms = c.symptom!
    return r
}


func fetchData<T: Codable>(from urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(NetworkError.invalidURL))
        return
    }

    let urlRequest = URLRequest(url: url)
    let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            completion(.failure(NetworkError.invalidResponse))
            return
        }

        guard let data = data else {
            completion(.failure(NetworkError.noData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            completion(.success(decodedData))
        } catch let decodingError {
            completion(.failure(decodingError))
        }
    }
    task.resume()
}

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
            print(error)
            return
        }
    }

    task.resume()
}

func updateFaculty(
    serverURL: String,
    faculty: Faculty_,
    completion: @escaping (Result<HTTPURLResponse, Error>) -> Void
) {
    guard let url = URL(string: "\(serverURL)faculties/\(faculty.id!.uuidString)") else {
        print("Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(faculty)
        request.httpBody = jsonData
    } catch {
        print("Failed to encode case log: \(error)")
        return
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print(error)
            return
        }
    }

    task.resume()
}
