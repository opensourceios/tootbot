//
// Copyright (C) 2017 Alexsander Akers and Tootbot Contributors
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published
// by the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import Freddy
import TootModel
import TootNetworking

public struct FollowRemoteAccountRequest: Request {
    public typealias ResponseObject = Account

    public var userAccount: UserAccount
    public var accountURI: String

    public init(userAccount: UserAccount, accountURI: String) {
        self.userAccount = userAccount
        self.accountURI = accountURI
    }

    func payload() -> Data? {
        return try? JSON.dictionary(["uri": accountURI.toJSON()]).serialize()
    }

    public func build() -> URLRequest {
        var request = URLRequest(url: userAccount.instanceURL.appendingPathComponent("api/v1/follows"))
        request.httpBody = payload()
        request.httpMethod = Method.post.rawValue
        request.setValue("Bearer \(userAccount.token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
