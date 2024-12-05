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
    var firstName: String = ""
    var lastName: String = ""
    var email: String = ""
    var preferences: [String: String]?
    var caseID: UUID?
}


struct Trainee_: Identifiable ,Codable {
    var id: UUID?
    var firstName: String?
    var lastName: String?
    var email: String?
    var isAvailableForCase: Bool = false
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
    r.firstName = t.firstName!
    r.lastName = t.lastName!
    r.emailAddress = t.email!
    r.isAvailableForCase = t.isAvailableForCase
    r.picture = t.photo!
    r.rotationID = ""
    r.evalScore = t.currentAvg!
    r.evalCount = t.evalNum!
    if t.caseID != nil {
        r.caseID = t.caseID!.uuidString
    }else{
        r.caseID = ""
    }
//    print(r.picture)
    return r
}


func traineeTrans2(_ t: Trainee) -> Trainee_ {
    let t = Trainee_(id: UUID(uuidString: t.traineeID), firstName: t.firstName, lastName: t.lastName, email: t.emailAddress, isAvailableForCase: t.isAvailableForCase, photo: t.picture, currentAvg: t.evalScore, evalNum: t.evalCount, caseID: UUID(uuidString: t.caseID))
//    print(t.photo!)
    return t
}

func facultyTrans2(_ f: Faculty) -> Faculty_ {
    let f = Faculty_(id: UUID(uuidString: f.id), firstName: f.fName, lastName: f.lName, email: f.email, preferences: f.preferences, caseID: UUID(uuidString: f.caseID))
    return f
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
    r.email = f.email
    print(f.email)
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

func updateTrainee(
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

// for Scheduler
func getAllTrainees(onError: @escaping (Error) -> Void) {
    var trainees: [Trainee_] = []
    let group = DispatchGroup()
    group.enter()
    fetchData(from: "http://vcm-44136.vm.duke.edu:8080/trainees") { (result: Result<[Trainee_], Error>) in
        DispatchQueue.main.async{
            switch result {
            case .success(let data):
                trainees = data
                ScheduleData.data.traineeList = []
                for t in trainees{
                    ScheduleData.data.traineeList.append(traineeTrans(t))
                }
            case .failure(let error):
                print("Error fetching cases:", error)
                    
                onError(error)
            }
            group.leave()
        }
    }
}

// for Scheduler
func getAllFaculties(onError: @escaping (Error) -> Void) {
    var faculties: [Faculty_] = []
    let group = DispatchGroup()
    group.enter()
    fetchData(from: "http://vcm-44136.vm.duke.edu:8080/faculties") { (result: Result<[Faculty_], Error>) in
        DispatchQueue.main.async{
            switch result {
            case .success(let data):
                faculties = data
                ScheduleData.data.facultyList = []
                for f in faculties {
                    ScheduleData.data.facultyList.append(facultyTrans(f))
                }
            case .failure(let error):
                print("Error fetching cases:", error)
                onError(error)
            }
            group.leave()
        }
    }
}

// for Scheduler
func getAllCases(onError: @escaping (Error) -> Void) {
    var cases: [Case_] = []
    let group = DispatchGroup()
    group.enter()
    fetchData(from: "http://vcm-44136.vm.duke.edu:8080/cases") { (result: Result<[Case_], Error>) in
        DispatchQueue.main.async{
            switch result {
            case .success(let data):
                cases = data
                ScheduleData.data.caseList = []
                for c in cases {
                    ScheduleData.data.caseList.append(caseTrans(c))
                }
            case .failure(let error):
                print("Error fetching cases:", error)
                onError(error)
            }
            group.leave()
        }
    }
}


// for Trainee
func getTraineee(_ traineeID: String) {
    let group = DispatchGroup()
    group.enter()
    var t: Trainee_ = Trainee_()
    fetchData(from: "http://vcm-44136.vm.duke.edu:8080/trainees/\(traineeID)") { (result: Result<Trainee_, Error>) in
        DispatchQueue.main.async{
            switch result {
            case .success(let data):
                t = data
                let trainee = traineeTrans(t)
                copyTrainee(from: trainee, to: Trainee.activeTrainee)
            case .failure(let error):
                print("Error fetching cases:", error)
            }
            group.leave()
        }
    }
}

// for Trainee
func getRelatedFaculties(_ caseID: String){
    var faculties: [Faculty_] = []
    let group = DispatchGroup()
    group.enter()
    fetchData(from: "http://vcm-44136.vm.duke.edu:8080/faculties") { (result: Result<[Faculty_], Error>) in
        DispatchQueue.main.async{
            switch result {
            case .success(let data):
                faculties = data
                Trainee.activeTrainee.relatedFaculties = []
                for f in faculties{
                    if f.caseID != nil && f.caseID!.uuidString.lowercased() == caseID.lowercased(){
                        Trainee.activeTrainee.relatedFaculties.append(facultyTrans(f))
                    }
                }
            case .failure(let error):
                print("Error fetching cases:", error)
            }
            group.leave()
        }
    }
}

// for Faculty
func getFaculty(_ facultyID: String) {
    let group = DispatchGroup()
    var f: Faculty_ = Faculty_()
    group.enter()
    fetchData(from: "http://vcm-44136.vm.duke.edu:8080/faculties/\(facultyID)") { (result: Result<Faculty_, Error>) in
        DispatchQueue.main.async{
            switch result {
            case .success(let data):
                f = data
                let faculty = facultyTrans(f)
                copyFaculty(from: faculty, to: Faculty.activeFaculty)
            case .failure(let error):
                print("Error fetching cases:", error)
            }
            group.leave()
        }
    }
}

// for Faculty
func getRelatedTrainees(_ caseID: String){
    var trainees: [Trainee_] = []
    let group = DispatchGroup()
    group.enter()
    fetchData(from: "http://vcm-44136.vm.duke.edu:8080/trainees") { (result: Result<[Trainee_], Error>) in
        DispatchQueue.main.async{
            switch result {
            case .success(let data):
                trainees = data
                Faculty.activeFaculty.relatedTrainees = []
                for t in trainees{
                    if t.caseID != nil && t.caseID!.uuidString.lowercased() == caseID.lowercased(){
                        Faculty.activeFaculty.relatedTrainees.append(traineeTrans(t))
                    }
                }
            case .failure(let error):
                print("Error fetching cases:", error)
            }
            group.leave()
        }
    }
}

// for Trainee and Faculty
func getCases(_ caseID: String) {
    Case.activeCase = Case()
    let group = DispatchGroup()
    var cases: [Case_] = []
    group.enter()
    fetchData(from: "http://vcm-44136.vm.duke.edu:8080/cases") { (result: Result<[Case_], Error>) in
        DispatchQueue.main.async{
            switch result {
            case .success(let data):
                cases = data
                for c in cases{
                    if c.id!.uuidString.lowercased() == caseID.lowercased(){
                        let tmp = caseTrans(c)
                        Case.activeCase.id = tmp.id
                        Case.activeCase.type = tmp.type
                        Case.activeCase.diagnosis = tmp.diagnosis
                        Case.activeCase.symptoms = tmp.symptoms
                        //print(Case.activeCase.id)
                        break
                    }
                }
            case .failure(let error):
                print("Error fetching cases:", error)
            }
            group.leave()
        }
    }
}

func upLoadTrainee(_ t: Trainee) {
    let t_: Trainee_ = traineeTrans2(t)
    updateTrainee(serverURL: "http://vcm-44136.vm.duke.edu:8080/", trainee: t_) { result in
        switch result {
        case .success(let response):
            print("Update succeeded with status code: \(response.statusCode)")
        case .failure(let error):
            print("Update failed: \(error.localizedDescription)")
        }
    }
}

func upLoadFaculty(_ f: Faculty) {
    let f_: Faculty_ = facultyTrans2(f)
    updateFaculty(serverURL: "http://vcm-44136.vm.duke.edu:8080/", faculty: f_) { result in
        switch result {
        case .success(let response):
            print("Update succeeded with status code: \(response.statusCode)")
        case .failure(let error):
            print("Update failed: \(error.localizedDescription)")
        }
    }
}
