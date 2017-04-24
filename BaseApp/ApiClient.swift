

import Alamofire
import BoltsSwift

class ApiClient: NSObject {
    static let sharedInstance = ApiClient()
    
    func callInBackground(_ request: ApiRequest) -> BoltsSwift.Task<Any> {
        let taskSource = TaskCompletionSource<Any>()
        Alamofire.request(request).responseJSON { (response: DataResponse<Any>) in
            if let statusCode = response.response?.statusCode, statusCode == 200 {
                //
                // Success
                //
                taskSource.set(result: self.parseApiResponse(response))
            } else {
                //
                // Error
                //
               // self.checkResponse(response)
                taskSource.set(error: self.parseApiError(response))
            }
        }
        return taskSource.task
    }
    
    func download(_ request: ApiRequest, toPath path: URL) -> BoltsSwift.Task<Any> {
        let taskSource = TaskCompletionSource<Any>()
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (path, [.removePreviousFile, .createIntermediateDirectories])
        }
        Alamofire.download(request, to: destination).response { response in
            if let imagePath = response.destinationURL?.path, response.response!.statusCode == 200 && !imagePath.isEmpty {
                taskSource.set(result: self.parseApiResponse(response, downloadPath: imagePath))
            } else {
                taskSource.set(error: self.parseApiError(response))
            }
        }
        return taskSource.task
    }
    
    // MARK:- Data Response
    func parseApiResponse(_ response: DataResponse<Any>) -> ApiResponse {
        if let value = response.result.value as? Dictionary<String, AnyObject> {
            let statusCode = parseIntFrom(value[""], defaultValue: response.response!.statusCode)
            let message = parseStringFrom(value[""], defaultValue: "")
            let point = parseIntFrom(value[""], defaultValue: 0)
            return ApiResponse(result: value, headers: response.response!.allHeaderFields, statusCode: statusCode, message: message, point: point)
            
        } else if let value = response.result.value as? [Dictionary<String, AnyObject>] {
            return ApiResponse(result: value, headers: response.response!.allHeaderFields, statusCode: response.response!.statusCode)
        } else {
            return ApiResponse(result: nil, headers: response.response!.allHeaderFields, statusCode: response.response!.statusCode)
        }
    }
    
    func parseApiError(_ response: DataResponse<Any>) -> ApiError {
        if let statusCode = response.response?.statusCode, let error = response.result.error  {
            //
            // Sever Error
            //
            var message = ""
            if let value = response.result.value as? Dictionary<String, AnyObject> {
                if let localizedMessage = getLocalizedMessageFromObject(value as Dictionary<NSObject, AnyObject>) {
                    message = localizedMessage
                }
            }
            return ApiError(statusCode: statusCode, error: error as NSError, message: message)
        } else {
            //
            // Unknown Error
            //
            return ApiError(statusCode: 0, error: NSError(domain: "", code: 0, userInfo: nil))
        }
    }

    // MARK:- Download Response
    func parseApiResponse(_ response: DefaultDownloadResponse, downloadPath: String) -> ApiResponse {
        return ApiResponse(result: downloadPath, headers: response.response!.allHeaderFields, statusCode: response.response!.statusCode)
    }
    
    func parseApiError(_ response: DefaultDownloadResponse) -> ApiError {
        if let statusCode = response.response?.statusCode, let error = response.error  {
            //
            // Sever Error
            //
            return ApiError(statusCode: statusCode, error: error as NSError, message: "")
        } else {
            //
            // Unknown Error
            //
            return ApiError(statusCode: 0, error: NSError(domain: "", code: 0, userInfo: nil))
        }
    }
    
}
