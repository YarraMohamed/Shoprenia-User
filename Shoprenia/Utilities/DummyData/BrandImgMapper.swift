//
//  BrandImgMapper.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import Foundation


func brandImageURL(for title: String) -> URL {
    let brandURLs: [String: String] = [
        "VANS": "https://logowik.com/content/uploads/images/vans8605.logowik.com.webp",
        "ADIDAS": "https://download.logo.wine/logo/Adidas/Adidas-Logo.wine.png",
        "NIKE": "https://i.pinimg.com/736x/29/df/c6/29dfc6f05b80804c18913851a79c5140.jpg",
        "CONVERSE": "https://loodibee.com/wp-content/uploads/Converse-Logo.png",
        "ASICS TIGER" : "https://logowik.com/content/uploads/images/asics-tiger6716.jpg",
        "PALLADUIM" : "https://www.chaussuresetcompagnie.fr/wp-content/uploads/2020/08/Palladium-logo.png",
        "PUMA" : "https://eyeexpressions.net/wp-content/uploads/2019/07/puma-logo-.png",
        "SUPRA" : "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/052011/supra_0.png?itok=zKX-Ty8j",
        "TIMBERLAND" : "https://logos-world.net/wp-content/uploads/2020/05/Timberland-Logo.png",
        "DR MARTENS" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSaHqzhpZJlZcWWwW_gJc-koW71LJkz5wtMQ&s",
        "HERSCHEL" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTFcWZpjgYACFi117SlV1dgfqqpWswOXUeSog&s",
        "FLEX FIT" : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3a1oZDDULQ8zpfm3WQa2Y_UKfkIralQlQdw&s"
    ]
    
    return URL(string: brandURLs[title] ?? "")!
}
