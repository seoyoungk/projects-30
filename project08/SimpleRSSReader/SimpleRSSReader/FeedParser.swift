//
//  FeedParser.swift
//  SimpleRSSReader
//
//  Created by Seoyoung on 22/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import Foundation

class FeedParser: NSObject, XMLParserDelegate {
    fileprivate var resItems = [(title: String, description: String, pubDate: String)]()
    fileprivate var currentElement = ""
    fileprivate var currentTitle = "" {
        didSet {
            // 문자열 앞뒤 공백 제거
            currentTitle = currentTitle.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var currentDescription = ""{
        didSet {
        currentDescription = currentDescription.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var currentPubDate = "" {
        didSet {
            currentPubDate = currentPubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        }
    }
    
    fileprivate var parserCompletionHandler: (([(title: String, description: String, pubDate: String)]) -> Void)?
    func parserFeed(feedURL: String, completionHandler: (([(title: String, description: String, pubDate: String)]) -> Void)?) -> Void {
        parserCompletionHandler = completionHandler
        // URL
        guard let feedURL = URL(string: feedURL) else {
            print("feed URL is invalid!")
            return
        }
        URLSession.shared.dataTask(with: feedURL, completionHandler: {data, response, error in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {
                print("No data fetched!")
                return
            }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }).resume()
    }
    // XMLParser Delegate
    func parserDidStartDocument(_ parser: XMLParser) {
        resItems.removeAll()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == "item" {
            currentTitle = ""
            currentDescription = ""
            currentPubDate = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title":
            currentTitle += string
        case "description":
            currentDescription += string
        case "pubDate":
            currentPubDate += string
        default:
            break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let resItem = (title: currentTitle, description: currentDescription, pubDate: currentPubDate)
            resItems.append(resItem)
        }
    }
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(resItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
