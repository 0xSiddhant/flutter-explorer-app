import Flutter

/// Service class for handling network operations
/// Includes GET, POST, PUT, DELETE API calls using URLSession
class NetworkService {

    func handleMethodCall(
        call: FlutterMethodCall, result: @escaping FlutterResult, activity: AppDelegate
    ) {
        switch call.method {
        case "getRequest":
            let args = call.arguments as? [String: Any]
            let url = args?["url"] as? String ?? ""
            let headers = args?["headers"] as? [String: String] ?? [:]
            performGetRequest(url: url, headers: headers, result: result)
        case "postRequest":
            let args = call.arguments as? [String: Any]
            let url = args?["url"] as? String ?? ""
            let headers = args?["headers"] as? [String: String] ?? [:]
            let body = args?["body"] as? String ?? ""
            performPostRequest(url: url, headers: headers, body: body, result: result)
        case "putRequest":
            let args = call.arguments as? [String: Any]
            let url = args?["url"] as? String ?? ""
            let headers = args?["headers"] as? [String: String] ?? [:]
            let body = args?["body"] as? String ?? ""
            performPutRequest(url: url, headers: headers, body: body, result: result)
        case "deleteRequest":
            let args = call.arguments as? [String: Any]
            let url = args?["url"] as? String ?? ""
            let headers = args?["headers"] as? [String: String] ?? [:]
            performDeleteRequest(url: url, headers: headers, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func performGetRequest(
        url: String, headers: [String: String], result: @escaping FlutterResult
    ) {
        guard let url = URL(string: url) else {
            result([
                "success": false,
                "error": "Invalid URL",
                "statusCode": -1,
            ])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    result([
                        "success": false,
                        "error": "Network error: \(error.localizedDescription)",
                        "statusCode": -1,
                    ])
                    return
                }

                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? -1
                let responseBody = data != nil ? String(data: data!, encoding: .utf8) ?? "" : ""

                var responseHeaders: [String: String] = [:]
                if let httpResponse = httpResponse {
                    for (key, value) in httpResponse.allHeaderFields {
                        if let key = key as? String, let value = value as? String {
                            responseHeaders[key] = value
                        }
                    }
                }

                result([
                    "success": statusCode >= 200 && statusCode < 300,
                    "statusCode": statusCode,
                    "headers": responseHeaders,
                    "body": responseBody,
                    "url": url.absoluteString,
                ])
            }
        }
        task.resume()
    }

    private func performPostRequest(
        url: String, headers: [String: String], body: String, result: @escaping FlutterResult
    ) {
        guard let url = URL(string: url) else {
            result([
                "success": false,
                "error": "Invalid URL",
                "statusCode": -1,
            ])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body.data(using: .utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    result([
                        "success": false,
                        "error": "Network error: \(error.localizedDescription)",
                        "statusCode": -1,
                    ])
                    return
                }

                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? -1
                let responseBody = data != nil ? String(data: data!, encoding: .utf8) ?? "" : ""

                var responseHeaders: [String: String] = [:]
                if let httpResponse = httpResponse {
                    for (key, value) in httpResponse.allHeaderFields {
                        if let key = key as? String, let value = value as? String {
                            responseHeaders[key] = value
                        }
                    }
                }

                result([
                    "success": statusCode >= 200 && statusCode < 300,
                    "statusCode": statusCode,
                    "headers": responseHeaders,
                    "body": responseBody,
                    "url": url.absoluteString,
                ])
            }
        }
        task.resume()
    }

    private func performPutRequest(
        url: String, headers: [String: String], body: String, result: @escaping FlutterResult
    ) {
        guard let url = URL(string: url) else {
            result([
                "success": false,
                "error": "Invalid URL",
                "statusCode": -1,
            ])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = body.data(using: .utf8)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    result([
                        "success": false,
                        "error": "Network error: \(error.localizedDescription)",
                        "statusCode": -1,
                    ])
                    return
                }

                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? -1
                let responseBody = data != nil ? String(data: data!, encoding: .utf8) ?? "" : ""

                var responseHeaders: [String: String] = [:]
                if let httpResponse = httpResponse {
                    for (key, value) in httpResponse.allHeaderFields {
                        if let key = key as? String, let value = value as? String {
                            responseHeaders[key] = value
                        }
                    }
                }

                result([
                    "success": statusCode >= 200 && statusCode < 300,
                    "statusCode": statusCode,
                    "headers": responseHeaders,
                    "body": responseBody,
                    "url": url.absoluteString,
                ])
            }
        }
        task.resume()
    }

    private func performDeleteRequest(
        url: String, headers: [String: String], result: @escaping FlutterResult
    ) {
        guard let url = URL(string: url) else {
            result([
                "success": false,
                "error": "Invalid URL",
                "statusCode": -1,
            ])
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    result([
                        "success": false,
                        "error": "Network error: \(error.localizedDescription)",
                        "statusCode": -1,
                    ])
                    return
                }

                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode ?? -1
                let responseBody = data != nil ? String(data: data!, encoding: .utf8) ?? "" : ""

                var responseHeaders: [String: String] = [:]
                if let httpResponse = httpResponse {
                    for (key, value) in httpResponse.allHeaderFields {
                        if let key = key as? String, let value = value as? String {
                            responseHeaders[key] = value
                        }
                    }
                }

                result([
                    "success": statusCode >= 200 && statusCode < 300,
                    "statusCode": statusCode,
                    "headers": responseHeaders,
                    "body": responseBody,
                    "url": url.absoluteString,
                ])
            }
        }
        task.resume()
    }
}
