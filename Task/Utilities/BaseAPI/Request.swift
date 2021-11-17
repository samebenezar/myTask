
import Foundation
import Alamofire

class Request {
    var url : String
    var method : HTTPMethod = .get
    var params : baseParams?
    var header  : [String:String]?
    var body  : Data?
    
    
    init(url :(Urls,APISuffix), method : HTTPMethod,params :baseParams? = nil, header : Bool,body :Data? = nil) {
        self.url = url.0.getDescription() + url.1.getDescription()
        self.method = method
        self.params = params
        if let token = UserDefaults.standard.string(forKey: "token") {
            //print(token)
            if header {
                self.header = [
                    "token" : token
                ]
            }
        }
        self.body = body
    }

    deinit {
        print(#file , "destructor called")
    }
}

class RequestFileData {
    let url: String
    var method: HTTPMethod = .post
    let parameters: baseParams?
    var headers: [String : String]?
    let fileData: Data
    let fileName : String
    let fileMimetype : String
    let fileparam  :String
    
    init(url: (Urls , APISuffix), method: HTTPMethod, parameters: baseParams? = nil, headers: Bool , fileData: Data , fileName : String , fileMimetype : String , fileParam : String) {
        self.url = url.0.getDescription() + url.1.getDescription()
        self.method = method
        self.parameters = parameters
        if let token = UserDefaults.standard.string(forKey: "token") {
            print(token)
            if(headers){
                
                self.headers = [
                    "token": "\(token)",
                ]
                
            }
        }
        self.fileData = fileData
        self.fileMimetype = fileMimetype
        self.fileName = fileName
        self.fileparam = fileParam
    }
    
    deinit {
        print(#file , "destructor called")
    }
}

class RequestMultipleFileData {
    let url: String
    var method: HTTPMethod = .post
    let parameters: baseParams?
    var headers: [String : String]?
    let fileData: [Data]
    let fileName : [String]
    let fileMimetype : [String]
    let fileparam  :[String]
    
    init(url: (Urls , APISuffix), method: HTTPMethod, parameters: baseParams? = nil, headers: Bool , fileData: [Data] , fileName : [String] , fileMimetype : [String] , fileParam : [String]) {
        self.url = url.0.getDescription() + url.1.getDescription()
        self.method = method
        self.parameters = parameters
        if let token = UserDefaults.standard.string(forKey: "token") {
            print(token)
            if(headers){
                self.headers = [
                    "token": "\(token)",
                ]
            }
        }
        self.fileData = fileData
        self.fileMimetype = fileMimetype
        self.fileName = fileName
        self.fileparam = fileParam
    }
    
    deinit {
        print(#file , "destructor called")
    }
}
