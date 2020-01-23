//
//  Copyright © 2017 Kalpesh Talkar. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  For support: https://gist.github.com/KalpeshTalkar/b0876a55fe049e96bc38a02fc7b74c04
//


import UIKit

extension UIStoryboard {
    
    /// Get UIViewController instance with the identifier
    ///
    /// - parameter identifier: id of the view controller given in storyboard
    ///
    /// - returns: new instance of UIViewController with the provided id
    func viewController(for identifier: String) -> UIViewController {
        return self.instantiateViewController(withIdentifier: identifier)
    }
    
    /// Get type casted UIViewController instance with the identifier
    ///
    /// - parameter type:       type of the UIViewController
    /// - parameter identifier: id of the view controller given in storyboard
    ///
    /// - returns: new instance of UIViewController with the provided id
    func viewController<T:UIViewController>(of type: T.Type, for identifier: String? = nil) -> T? {
        let id = identifier ?? String(describing: T.self)
        return self.instantiateViewController(withIdentifier: id) as? T
    }
}

struct Storyboard {
    static let Main = UIStoryboard(name: "Main", bundle: nil)
}
