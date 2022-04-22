/*
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import XCTest

class DaysUntilBirthdayUITests_iOS_: XCTestCase {
  private let signInStaticText =
    "“DaysUntilBirthday(iOS)” Wants to Use “google.com” to Sign In"
  private let timeout: TimeInterval = 2
  private let sampleApp = XCUIApplication()
  private let springboardApp = XCUIApplication(
    bundleIdentifier: "com.apple.springboard"
  )

  func testSwiftUIButtonTapStartsFlow() {
    sampleApp.launch()
    let signInButton = sampleApp.buttons["GoogleSignInButton"]
    XCTAssertTrue(signInButton.exists)
    signInButton.tap()

    guard springboardApp
            .staticTexts[signInStaticText]
            .waitForExistence(timeout: timeout) else {
      return XCTFail("Failed to display prompt")
    }
  }

  func testReadingSecretsFromConfig() {
    XCTAssertNotNil(Credential.bundle)
    XCTAssertEqual(Credential.email.rawValue, "secret_fake_email@gmail.com")
    XCTAssertEqual(Credential.password.rawValue, "foobar")
  }
}