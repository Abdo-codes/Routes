//
//  String+ClassName.swift
//  Routes
//
//  Created by Abdoelrhman Eaita on 19/06/2021.
//

import Foundation


extension String {
    var className: String? {
        guard let appName = Bundle.main.infoDictionary?["CFBundleName"] as? String else { return nil }
        return "\(appName).\(self)"
    }
}
