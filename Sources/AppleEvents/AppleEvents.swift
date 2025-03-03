import CoreServices
import Foundation
#if compiler(>=6.0)
private import AppleEventsC
#else
@_implementationOnly import AppleEventsC
#endif

// Enforce minimum Swift version for all platforms and build systems.
#if swift(<5.9)
#error("AppleEvents doesn't support Swift versions below 5.59.")
#endif

/// Current AppleEvents version 0.0.3. Necessary since SPM doesn't use dynamic libraries. Plus this will be more accurate.
let version = "0.0.3"

public enum AppleEvent: Sendable {
    case restart
    case shutDown
    case logOut
    case sleep
    case emptyTrash

    private var eventID: AEEventID {
        switch self {
        case .restart:
            return AEEventID(kAERestart)
        case .shutDown:
            return AEEventID(kAEShutDown)
        case .logOut:
            return AEEventID(kAEReallyLogOut)
        case .sleep:
            return AEEventID(kAESleep)
        case .emptyTrash:
            return AEEventID(kAEEmpty)
        }
    }

    public func perform() {
        SendAppleEventToSystemProcess(eventID)
    }
}
