////////////////////////////////////////////////////////////////////////////////
//
// Copyright 2021 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////

import Flutter
import UIKit

// This is the iOS plugin entry point. Under Swift Package Manager the plugin is
// a single Swift target, so the Flutter `pluginClass: RealmPlugin` (see the
// realm package pubspec) resolves directly to this class. `@objc(RealmPlugin)`
// keeps the class discoverable by the Objective-C plugin registrant that
// CocoaPods generates, so the same source serves both integrations.
//
// The former `RealmPlugin.m` Objective-C forwarder and `platform.mm` (which
// only defined `realm_dart_get_bundle_id`) were dropped from the iOS target:
// both are vestigial here — the symbol has no Dart call sites, and all native
// work (file paths, database ops) goes through the realm_dart.xcframework
// dylib's own exported symbols, loaded from the app bundle's Frameworks dir.
@objc(RealmPlugin)
public class RealmPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "realm", binaryMessenger: registrar.messenger())
    let instance = RealmPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
