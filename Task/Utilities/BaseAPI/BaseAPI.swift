

import Foundation
import Alamofire
import SDWebImage

typealias baseParams = [String : AnyObject]
typealias baseApiCompletion = (Any?,String?,Int) -> Swift.Void

class BaseAPI {
    func hitApi(requests :Request,completion : @escaping baseApiCompletion ) {
        
        var request = URLRequest(url: URL(string: String(describing: requests.url))!)
        
        request.httpMethod = requests.method.rawValue
        
        request.allHTTPHeaderFields = requests.header ?? [:]
        
        if requests.params != nil {
            defer{
                print("------------- PARAMETERS---------------")
            }
            print("------------- PARAMETERS---------------")
            print(requests.params)
            do {
                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.params ?? [:], options: .prettyPrinted)
            }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dump(request)
        
        let task =  AF.request(request as URLRequestConvertible)
        
        task.responseJSON { [weak self] (response) in
            
            print(response)
            
            self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
                completion(receivedData,message,response )
            })
        }
    }
    
    func hitApiWithLiveURL(requests :Request,completion : @escaping baseApiCompletion ) {
        
        var request = URLRequest(url: URL(string: String(describing: requests.url))!)
        request.httpMethod = requests.method.rawValue
        request.allHTTPHeaderFields = requests.header ?? [:]
        request.addValue("test229267", forHTTPHeaderField: "x-Username")
        request.addValue("TMX1512291534825461", forHTTPHeaderField: "x-DomainKey")
        request.addValue("test", forHTTPHeaderField: "x-system")
        request.addValue("test@229", forHTTPHeaderField: "x-Password")
        request.addValue("gzip,deflate", forHTTPHeaderField: "Accept-Encoding")
        if requests.params != nil {
            defer{
                print("------------- PARAMETERS---------------")
            }
            print("------------- PARAMETERS---------------")
            print(requests.params)
            do {
                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.params ?? [:], options: .prettyPrinted)
            }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dump(request)
        
        let task =  AF.request(request as URLRequestConvertible)
        
        task.responseJSON { [weak self] (response) in
            
            print(response)
            
            self?.serializedResponse(withResponse: response, clouser: { (receivedData, message, response) in
                completion(receivedData,message,response )
            })
        }
    }
    
    func serializedResponse(withResponse response: AFDataResponse<Any> , clouser: @escaping baseApiCompletion) {
            if response.response != nil {
                
                if let json = response.value {
                    
                    switch response.response?.statusCode ?? -91 {
                        
                    case 0...100 :
                        //print("* * * * * * FAILED * * * * * * ")
                        clouser(json, response.description , 0)
                        
                    case 101...199 :
                        print("* * * * * *  FAILED * * * * * * ")
                        clouser(json, response.description, 0)
                        
                    case 200...299:
                        print("* * * * * *  SUCCESS * * * * * * ")
                        clouser(json, response.description ,1)
                        
                    case 300...399:
                        //print("* * * * * *  FAILED * * * * * * ")
                        clouser(json, response.description ,2)
                        
                    case 400...410:
                        //print("* * * * * *  FAILED * * * * * * ")
                        clouser(json, response.description ,2)
                        
                    default :
                        //print("* * * * * * FAILED * * * * * * ")
                        clouser(json,(((response.value as? [String: AnyObject])? ["errors"] as? [String: AnyObject])?["msg"] as? String ?? "") , 2)
                        
    //                    ((((((response.result.value as? [String: AnyObject])? ["errors"] as? [String: AnyObject])?["msg"] as? [[String:AnyObject]]))?.first)?["msg"] as? String ?? "")
                        
                    }
                    
                } else {
                    print("* * * * * * * FAILED * * * * * * ")
                    clouser(nil,response.description, 2)
                    
                }
            } else {
                print("* * * * * * * FAILED * * * * * * ")
                clouser(nil,"Could not connect to the server", 2)
                
            }
        }
    
    func hitApiWithSingleFile(requests : RequestFileData , completion : @escaping baseApiCompletion ) {
        
        var request = URLRequest(url: URL(string: requests.url)!)
        
        request.httpMethod = requests.method.rawValue
        
        request.allHTTPHeaderFields = requests.headers
        
        let parameters = requests.parameters ?? [:]
        
        if requests.parameters != nil {
            do {
                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.parameters ?? [:], options: .prettyPrinted)
            }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dump(request)
        
        AF.upload(multipartFormData: { multipart_FormData in
            
            multipart_FormData.append(requests.fileData, withName: requests.fileparam, fileName: requests.fileName, mimeType: requests.fileMimetype)
            
            for (key, value) in parameters {
                
                if let array = value as? [AnyObject] {
                    
                    for i in array {
                        multipart_FormData.append(String(describing: i).data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    /*   if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                     multipart_FormData.append(jsonData, withName: key as String)
                     _}
                     _            */
                    
                }else if let _ = value as? Parameters {
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                        multipart_FormData.append(jsonData, withName: key as String)
                    }
                    
                } else {
                    multipart_FormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    
                }
                
            }
            
        },with: request).responseJSON { encodingResult in
           
            switch encodingResult.result {

            case .success(_):

                    if let json = encodingResult.value {

                        switch encodingResult.response?.statusCode ?? -91 {

                        case 0...100 :
                            completion(json, encodingResult.description , 0)

                        case 101...199 :
                            completion(json, encodingResult.description, 0)

                        case 200...299:
                            print("* * * * * * * SUCCESS * * * * * * ")
                            completion(json, encodingResult.description ,1)

                        case 300...399:
                            completion(json, encodingResult.description ,2)

                        default :
                            completion(json,encodingResult.description, 2)
                        }


                    }else {
                        completion(nil,encodingResult.description, 2)

                    }
                
            case .failure(let encodingError):

                completion(["Error":encodingError] as Any,"Error", 2)

            }
        }
    }
    
    func hitApiWithMultipleFile(requests : RequestMultipleFileData , completion : @escaping baseApiCompletion ) {
        
        var request = URLRequest(url: URL(string: requests.url)!)
        
        request.httpMethod = requests.method.rawValue
        
        request.allHTTPHeaderFields = requests.headers
        
        let parameters = requests.parameters ?? [:]
        
        if requests.parameters != nil {
            do {
                request.httpBody = try? JSONSerialization.data(withJSONObject: requests.parameters ?? [:], options: .prettyPrinted)
            }
        }
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        dump(request)
        
        AF.upload(multipartFormData: { multipart_FormData in
            
            for i in 0..<requests.fileData.count {
                multipart_FormData.append(requests.fileData[i], withName: requests.fileparam[i], fileName: requests.fileName[i], mimeType: requests.fileMimetype[i])
            }

            for (key, value) in parameters {
                
                if let array = value as? [AnyObject] {
                    
                    for i in array {
                        multipart_FormData.append(String(describing: i).data(using: String.Encoding.utf8)!, withName: key as String)
                    }
                    
                    /*   if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                     multipart_FormData.append(jsonData, withName: key as String)
                     _}
                     _            */
                    
                }else if let _ = value as? Parameters {
                    
                    if let jsonData = try? JSONSerialization.data(withJSONObject: value, options:[]) {
                        multipart_FormData.append(jsonData, withName: key as String)
                    }
                    
                } else {
                    multipart_FormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    
                }
                
            }
            
       },with: request ).responseJSON { encodingResult in
           
           switch encodingResult.result {

           case .success(_):

                   if let json = encodingResult.value {

                       switch encodingResult.response?.statusCode ?? -91 {

                       case 0...100 :
                           completion(json, encodingResult.description , 0)

                       case 101...199 :
                           completion(json, encodingResult.description, 0)

                       case 200...299:
                           print("* * * * * * * SUCCESS * * * * * * ")
                           completion(json, encodingResult.description ,1)

                       case 300...399:
                           completion(json, encodingResult.description ,2)

                       default :
                           completion(json,encodingResult.description, 2)
                       }


                   }else {
                       completion(nil,encodingResult.description, 2)

                   }
               
           case .failure(let encodingError):

               completion(["Error":encodingError] as Any,"Error", 2)

           }
       }
    }
}

