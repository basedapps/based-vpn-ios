// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Countries {
    /// Choose Country
    internal static let navigation = L10n.tr("Localizable", "Countries.Navigation", fallback: "Choose Country")
    internal enum Item {
      /// %d servers available
      internal static func servers(_ p1: Int) -> String {
        return L10n.tr("Localizable", "Countries.Item.Servers", p1, fallback: "%d servers available")
      }
    }
  }
  internal enum Home {
    internal enum Button {
      /// CONNECT TO VPN
      internal static let connect = L10n.tr("Localizable", "Home.Button.Connect", fallback: "CONNECT TO VPN")
      /// DISCONNECT
      internal static let disconnect = L10n.tr("Localizable", "Home.Button.Disconnect", fallback: "DISCONNECT")
    }
    internal enum Connection {
      /// Localizable.strings
      ///   BasedVPN
      /// 
      ///   Created by Lika Vorobeva on 19.07.2023.
      internal static let ip = L10n.tr("Localizable", "Home.Connection.IP", fallback: "YOUR IP ADDRESS")
      internal enum Ip {
        /// Unknown
        internal static let unknown = L10n.tr("Localizable", "Home.Connection.IP.Unknown", fallback: "Unknown")
      }
    }
  }
  internal enum Settings {
    /// Settings
    internal static let navigation = L10n.tr("Localizable", "Settings.Navigation", fallback: "Settings")
    internal enum Dns {
      /// Cloudflare DNS
      internal static let cloudflare = L10n.tr("Localizable", "Settings.DNS.Cloudflare", fallback: "Cloudflare DNS")
      /// Google Public DNS
      internal static let google = L10n.tr("Localizable", "Settings.DNS.Google", fallback: "Google Public DNS")
      /// Handshake DNS
      internal static let handshake = L10n.tr("Localizable", "Settings.DNS.Handshake", fallback: "Handshake DNS")
      /// DNS Server
      internal static let title = L10n.tr("Localizable", "Settings.DNS.Title", fallback: "DNS Server")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
