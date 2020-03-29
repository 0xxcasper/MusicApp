//
//  JsonHelper.swift
//  MusicApp
//
//  Created by admin on 29/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation


struct Region {
    var gl: String!
    var name: String!
    var selected: Bool = false
}

class JsonHelper {

    class func readJSONFromFile(fileName: String) -> [Region]
    {
        var regions: [Region] = []
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = json as? [Dictionary<String, AnyObject>] {
                    jsonResult.forEach { data in
                        if let region = data["region"] {
                            regions.append(Region(gl: (region["gl"] ?? "") as? String,
                                                name: (region["name"] ?? "") as? String))
                        }
                    }
                    return regions
                }
            } catch {
                
            }
        }
        return regions
    }
    
    class func getRegionName() -> String {
        let regions = self.readJSONFromFile(fileName: "Region")
        var name = ""
        regions.forEach { (Region) in
            if Region.gl == UserDefaultHelper.shared.regionCode {
                name = Region.name
            }
        }
        return name
    }
}
