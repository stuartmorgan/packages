// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v22.4.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Any?

  init(code: String, message: String?, details: Any?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
  }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

enum SK2ProductTypeMessage: Int {
  /// A consumable in-app purchase.
  case consumable = 0
  /// A non-consumable in-app purchase.
  case nonConsumable = 1
  /// A non-renewing subscription.
  case nonRenewable = 2
  /// An auto-renewable subscription.
  case autoRenewable = 3
}

enum SK2SubscriptionOfferTypeMessage: Int {
  case introductory = 0
  case promotional = 1
}

enum SK2SubscriptionOfferPaymentModeMessage: Int {
  case payAsYouGo = 0
  case payUpFront = 1
  case freeTrial = 2
}

enum SK2SubscriptionPeriodUnitMessage: Int {
  case day = 0
  case week = 1
  case month = 2
  case year = 3
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2SubscriptionOfferMessage {
  var id: String? = nil
  var price: Double
  var type: SK2SubscriptionOfferTypeMessage
  var period: SK2SubscriptionPeriodMessage
  var periodCount: Int64
  var paymentMode: SK2SubscriptionOfferPaymentModeMessage

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> SK2SubscriptionOfferMessage? {
    let id: String? = nilOrValue(pigeonVar_list[0])
    let price = pigeonVar_list[1] as! Double
    let type = pigeonVar_list[2] as! SK2SubscriptionOfferTypeMessage
    let period = pigeonVar_list[3] as! SK2SubscriptionPeriodMessage
    let periodCount = pigeonVar_list[4] as! Int64
    let paymentMode = pigeonVar_list[5] as! SK2SubscriptionOfferPaymentModeMessage

    return SK2SubscriptionOfferMessage(
      id: id,
      price: price,
      type: type,
      period: period,
      periodCount: periodCount,
      paymentMode: paymentMode
    )
  }
  func toList() -> [Any?] {
    return [
      id,
      price,
      type,
      period,
      periodCount,
      paymentMode,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2SubscriptionPeriodMessage {
  /// The number of units that the period represents.
  var value: Int64
  /// The unit of time that this period represents.
  var unit: SK2SubscriptionPeriodUnitMessage

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> SK2SubscriptionPeriodMessage? {
    let value = pigeonVar_list[0] as! Int64
    let unit = pigeonVar_list[1] as! SK2SubscriptionPeriodUnitMessage

    return SK2SubscriptionPeriodMessage(
      value: value,
      unit: unit
    )
  }
  func toList() -> [Any?] {
    return [
      value,
      unit,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2SubscriptionInfoMessage {
  /// An array of all the promotional offers configured for this subscription.
  var promotionalOffers: [SK2SubscriptionOfferMessage]
  /// The group identifier for this subscription.
  var subscriptionGroupID: String
  /// The duration that this subscription lasts before auto-renewing.
  var subscriptionPeriod: SK2SubscriptionPeriodMessage

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> SK2SubscriptionInfoMessage? {
    let promotionalOffers = pigeonVar_list[0] as! [SK2SubscriptionOfferMessage]
    let subscriptionGroupID = pigeonVar_list[1] as! String
    let subscriptionPeriod = pigeonVar_list[2] as! SK2SubscriptionPeriodMessage

    return SK2SubscriptionInfoMessage(
      promotionalOffers: promotionalOffers,
      subscriptionGroupID: subscriptionGroupID,
      subscriptionPeriod: subscriptionPeriod
    )
  }
  func toList() -> [Any?] {
    return [
      promotionalOffers,
      subscriptionGroupID,
      subscriptionPeriod,
    ]
  }
}

/// A Pigeon message class representing a Product
/// https://developer.apple.com/documentation/storekit/product
///
/// Generated class from Pigeon that represents data sent in messages.
struct SK2ProductMessage {
  /// The unique product identifier.
  var id: String
  /// The localized display name of the product, if it exists.
  var displayName: String
  /// The localized description of the product.
  var description: String
  /// The localized string representation of the product price, suitable for display.
  var price: Double
  /// The localized price of the product as a string.
  var displayPrice: String
  /// The types of in-app purchases.
  var type: SK2ProductTypeMessage
  /// The subscription information for an auto-renewable subscription.
  var subscription: SK2SubscriptionInfoMessage? = nil
  /// The currency and locale information for this product
  var priceLocale: SK2PriceLocaleMessage

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> SK2ProductMessage? {
    let id = pigeonVar_list[0] as! String
    let displayName = pigeonVar_list[1] as! String
    let description = pigeonVar_list[2] as! String
    let price = pigeonVar_list[3] as! Double
    let displayPrice = pigeonVar_list[4] as! String
    let type = pigeonVar_list[5] as! SK2ProductTypeMessage
    let subscription: SK2SubscriptionInfoMessage? = nilOrValue(pigeonVar_list[6])
    let priceLocale = pigeonVar_list[7] as! SK2PriceLocaleMessage

    return SK2ProductMessage(
      id: id,
      displayName: displayName,
      description: description,
      price: price,
      displayPrice: displayPrice,
      type: type,
      subscription: subscription,
      priceLocale: priceLocale
    )
  }
  func toList() -> [Any?] {
    return [
      id,
      displayName,
      description,
      price,
      displayPrice,
      type,
      subscription,
      priceLocale,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct SK2PriceLocaleMessage {
  var currencyCode: String
  var currencySymbol: String

  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> SK2PriceLocaleMessage? {
    let currencyCode = pigeonVar_list[0] as! String
    let currencySymbol = pigeonVar_list[1] as! String

    return SK2PriceLocaleMessage(
      currencyCode: currencyCode,
      currencySymbol: currencySymbol
    )
  }
  func toList() -> [Any?] {
    return [
      currencyCode,
      currencySymbol,
    ]
  }
}

private class sk2_pigeonPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return SK2ProductTypeMessage(rawValue: enumResultAsInt)
      }
      return nil
    case 130:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return SK2SubscriptionOfferTypeMessage(rawValue: enumResultAsInt)
      }
      return nil
    case 131:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return SK2SubscriptionOfferPaymentModeMessage(rawValue: enumResultAsInt)
      }
      return nil
    case 132:
      let enumResultAsInt: Int? = nilOrValue(self.readValue() as! Int?)
      if let enumResultAsInt = enumResultAsInt {
        return SK2SubscriptionPeriodUnitMessage(rawValue: enumResultAsInt)
      }
      return nil
    case 133:
      return SK2SubscriptionOfferMessage.fromList(self.readValue() as! [Any?])
    case 134:
      return SK2SubscriptionPeriodMessage.fromList(self.readValue() as! [Any?])
    case 135:
      return SK2SubscriptionInfoMessage.fromList(self.readValue() as! [Any?])
    case 136:
      return SK2ProductMessage.fromList(self.readValue() as! [Any?])
    case 137:
      return SK2PriceLocaleMessage.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class sk2_pigeonPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? SK2ProductTypeMessage {
      super.writeByte(129)
      super.writeValue(value.rawValue)
    } else if let value = value as? SK2SubscriptionOfferTypeMessage {
      super.writeByte(130)
      super.writeValue(value.rawValue)
    } else if let value = value as? SK2SubscriptionOfferPaymentModeMessage {
      super.writeByte(131)
      super.writeValue(value.rawValue)
    } else if let value = value as? SK2SubscriptionPeriodUnitMessage {
      super.writeByte(132)
      super.writeValue(value.rawValue)
    } else if let value = value as? SK2SubscriptionOfferMessage {
      super.writeByte(133)
      super.writeValue(value.toList())
    } else if let value = value as? SK2SubscriptionPeriodMessage {
      super.writeByte(134)
      super.writeValue(value.toList())
    } else if let value = value as? SK2SubscriptionInfoMessage {
      super.writeByte(135)
      super.writeValue(value.toList())
    } else if let value = value as? SK2ProductMessage {
      super.writeByte(136)
      super.writeValue(value.toList())
    } else if let value = value as? SK2PriceLocaleMessage {
      super.writeByte(137)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class sk2_pigeonPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return sk2_pigeonPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return sk2_pigeonPigeonCodecWriter(data: data)
  }
}

class sk2_pigeonPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = sk2_pigeonPigeonCodec(readerWriter: sk2_pigeonPigeonCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol InAppPurchase2API {
  func canMakePayments() throws -> Bool
  func products(
    identifiers: [String], completion: @escaping (Result<[SK2ProductMessage], Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class InAppPurchase2APISetup {
  static var codec: FlutterStandardMessageCodec { sk2_pigeonPigeonCodec.shared }
  /// Sets up an instance of `InAppPurchase2API` to handle messages through the `binaryMessenger`.
  static func setUp(
    binaryMessenger: FlutterBinaryMessenger, api: InAppPurchase2API?,
    messageChannelSuffix: String = ""
  ) {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let canMakePaymentsChannel = FlutterBasicMessageChannel(
      name:
        "dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchase2API.canMakePayments\(channelSuffix)",
      binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      canMakePaymentsChannel.setMessageHandler { _, reply in
        do {
          let result = try api.canMakePayments()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      canMakePaymentsChannel.setMessageHandler(nil)
    }
    let productsChannel = FlutterBasicMessageChannel(
      name:
        "dev.flutter.pigeon.in_app_purchase_storekit.InAppPurchase2API.products\(channelSuffix)",
      binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      productsChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let identifiersArg = args[0] as! [String]
        api.products(identifiers: identifiersArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      productsChannel.setMessageHandler(nil)
    }
  }
}
