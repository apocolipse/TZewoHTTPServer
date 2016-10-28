TZewoHTTPServer
======================

License
--------
The MIT License (MIT)

Copyright (c) 2016 Apocolipse

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.


About
========

TZewoHTTPServer is a CSP based HTTPServer for [Thrift](https://github.com/apache/thrift) using [Zewo's](https://github.com/zewo/zewo) CSP based HTTPServer.  It uses the Swift 3 native thrift library (located [here](https://github.com/apocolipse/thrift-swift)).

Usage
========
To use TZewoHTTPServer, you must already have a Thrift service that you want to serve.

Adding dependancy
--------
Add the following in `Package.swift`
```swift
  dependencies: [
    .Package(url: "../../TZewoHTTPServer", majorVersion: 0, minor: 1),
  ]
```

Creating and starting a server
--------
To create a server, you must have a concrete Service to serve, and provide classes for protocols and processors used
```swift
let service = MyService()

let server = try? TZewoHTTPServer(port: 9090,
                                  service: service,
                                  inProtocol: TBinaryProtocol.self,
                                  outProtocol: TBinaryProtocol.self,
                                  processor: MyServiceProcessor.self)

try? server?.serve()                                  
```



Questions and Support
=====================
I can usually be found floating around #thrift and #swift on FreeNode, as well as on Zewo's official [Slack](http://slack.zewo.io/), feel free to bombard with questions.
