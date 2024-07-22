// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// Autogenerated from Pigeon (v21.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

#undef _HAS_EXCEPTIONS

#include "messages.g.h"

#include <flutter/basic_message_channel.h>
#include <flutter/binary_messenger.h>
#include <flutter/encodable_value.h>
#include <flutter/standard_message_codec.h>

#include <map>
#include <optional>
#include <string>

namespace local_auth_windows {
using flutter::BasicMessageChannel;
using flutter::CustomEncodableValue;
using flutter::EncodableList;
using flutter::EncodableMap;
using flutter::EncodableValue;

FlutterError CreateConnectionError(const std::string channel_name) {
  return FlutterError(
      "channel-error",
      "Unable to establish connection on channel: '" + channel_name + "'.",
      EncodableValue(""));
}

PigeonCodecSerializer::PigeonCodecSerializer() {}

EncodableValue PigeonCodecSerializer::ReadValueOfType(
    uint8_t type, flutter::ByteStreamReader* stream) const {
  return flutter::StandardCodecSerializer::ReadValueOfType(type, stream);
}

void PigeonCodecSerializer::WriteValue(
    const EncodableValue& value, flutter::ByteStreamWriter* stream) const {
  flutter::StandardCodecSerializer::WriteValue(value, stream);
}

/// The codec used by LocalAuthApi.
const flutter::StandardMessageCodec& LocalAuthApi::GetCodec() {
  return flutter::StandardMessageCodec::GetInstance(
      &PigeonCodecSerializer::GetInstance());
}

// Sets up an instance of `LocalAuthApi` to handle messages through the
// `binary_messenger`.
void LocalAuthApi::SetUp(flutter::BinaryMessenger* binary_messenger,
                         LocalAuthApi* api) {
  LocalAuthApi::SetUp(binary_messenger, api, "");
}

void LocalAuthApi::SetUp(flutter::BinaryMessenger* binary_messenger,
                         LocalAuthApi* api,
                         const std::string& message_channel_suffix) {
  const std::string prepended_suffix =
      message_channel_suffix.length() > 0
          ? std::string(".") + message_channel_suffix
          : "";
  {
    BasicMessageChannel<> channel(
        binary_messenger,
        "dev.flutter.pigeon.local_auth_windows.LocalAuthApi.isDeviceSupported" +
            prepended_suffix,
        &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler(
          [api](const EncodableValue& message,
                const flutter::MessageReply<EncodableValue>& reply) {
            try {
              api->IsDeviceSupported([reply](ErrorOr<bool>&& output) {
                if (output.has_error()) {
                  reply(WrapError(output.error()));
                  return;
                }
                EncodableList wrapped;
                wrapped.push_back(
                    EncodableValue(std::move(output).TakeValue()));
                reply(EncodableValue(std::move(wrapped)));
              });
            } catch (const std::exception& exception) {
              reply(WrapError(exception.what()));
            }
          });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
  {
    BasicMessageChannel<> channel(
        binary_messenger,
        "dev.flutter.pigeon.local_auth_windows.LocalAuthApi.authenticate" +
            prepended_suffix,
        &GetCodec());
    if (api != nullptr) {
      channel.SetMessageHandler(
          [api](const EncodableValue& message,
                const flutter::MessageReply<EncodableValue>& reply) {
            try {
              const auto& args = std::get<EncodableList>(message);
              const auto& encodable_localized_reason_arg = args.at(0);
              if (encodable_localized_reason_arg.IsNull()) {
                reply(WrapError("localized_reason_arg unexpectedly null."));
                return;
              }
              const auto& localized_reason_arg =
                  std::get<std::string>(encodable_localized_reason_arg);
              api->Authenticate(
                  localized_reason_arg, [reply](ErrorOr<bool>&& output) {
                    if (output.has_error()) {
                      reply(WrapError(output.error()));
                      return;
                    }
                    EncodableList wrapped;
                    wrapped.push_back(
                        EncodableValue(std::move(output).TakeValue()));
                    reply(EncodableValue(std::move(wrapped)));
                  });
            } catch (const std::exception& exception) {
              reply(WrapError(exception.what()));
            }
          });
    } else {
      channel.SetMessageHandler(nullptr);
    }
  }
}

EncodableValue LocalAuthApi::WrapError(std::string_view error_message) {
  return EncodableValue(
      EncodableList{EncodableValue(std::string(error_message)),
                    EncodableValue("Error"), EncodableValue()});
}

EncodableValue LocalAuthApi::WrapError(const FlutterError& error) {
  return EncodableValue(EncodableList{EncodableValue(error.code()),
                                      EncodableValue(error.message()),
                                      error.details()});
}

}  // namespace local_auth_windows
