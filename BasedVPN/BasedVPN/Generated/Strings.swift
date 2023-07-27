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
  internal enum Error {
    /// Something is missing. Try in 15 minutes or contact support.
    internal static let invalidRequest = L10n.tr("Localizable", "Error.InvalidRequest", fallback: "Something is missing. Try in 15 minutes or contact support.")
    /// Requested resource cannot be found on the server
    internal static let notFound = L10n.tr("Localizable", "Error.NotFound", fallback: "Requested resource cannot be found on the server")
    /// Retry
    internal static let retry = L10n.tr("Localizable", "Error.Retry", fallback: "Retry")
    /// Select server is unavailable.
    internal static let serverUnavailable = L10n.tr("Localizable", "Error.ServerUnavailable", fallback: "Select server is unavailable.")
    /// Action is temporary unavailable. Try in 15 minutes or contact support.
    internal static let temporaryUnavailable = L10n.tr("Localizable", "Error.TemporaryUnavailable", fallback: "Action is temporary unavailable. Try in 15 minutes or contact support.")
    /// Please allow the tunnel creation to connect to your session
    internal static let tunnelCreationDenied = L10n.tr("Localizable", "Error.TunnelCreationDenied", fallback: "Please allow the tunnel creation to connect to your session")
    /// Failed to create a tunnel. Make sure you allow tunnel creation.
    internal static let tunnelCreationFailed = L10n.tr("Localizable", "Error.TunnelCreationFailed", fallback: "Failed to create a tunnel. Make sure you allow tunnel creation.")
    /// Your session’s expired. Please, retry again or restart the app.
    internal static let unauthorizedDevice = L10n.tr("Localizable", "Error.UnauthorizedDevice", fallback: "Your session’s expired. Please, retry again or restart the app.")
    /// Something went wrong.
    internal static let unknownError = L10n.tr("Localizable", "Error.UnknownError", fallback: "Something went wrong.")
  }
  internal enum ErrorState {
    internal enum Empty {
      /// No Results Found.
      internal static let description = L10n.tr("Localizable", "ErrorState.Empty.Description", fallback: "No Results Found.")
      /// Sorry!
      internal static let title = L10n.tr("Localizable", "ErrorState.Empty.Title", fallback: "Sorry!")
    }
    internal enum Failure {
      /// Retry
      internal static let button = L10n.tr("Localizable", "ErrorState.Failure.Button", fallback: "Retry")
      /// Failed to fetch data from the server.
      internal static let description = L10n.tr("Localizable", "ErrorState.Failure.Description", fallback: "Failed to fetch data from the server.")
      /// Ugh-oh! Something Went Wrong!
      internal static let title = L10n.tr("Localizable", "ErrorState.Failure.Title", fallback: "Ugh-oh! Something Went Wrong!")
    }
  }
  internal enum Home {
    internal enum Button {
      /// CONNECT TO VPN
      internal static let connect = L10n.tr("Localizable", "Home.Button.Connect", fallback: "CONNECT TO VPN")
      /// Select a server
      internal static let countries = L10n.tr("Localizable", "Home.Button.Countries", fallback: "Select a server")
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
        /// Your connection appears to be unstable or offline
        internal static let error = L10n.tr("Localizable", "Home.Connection.IP.Error", fallback: "Your connection appears to be unstable or offline")
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
