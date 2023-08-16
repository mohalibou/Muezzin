//
//  CalculationMethod+Ext.swift
//  Muezzin
//
//  Created by Mohamed Ali Boutaleb on 4/26/23.
//

import Adhan
import Foundation

extension CalculationMethod {
    
    // remove .other case
    static func usefulCases() -> [CalculationMethod] {
        var methods = CalculationMethod.allCases
        methods.removeAll { $0 == .other }
        return methods
    }
    
    func localizedString() -> String {
        switch self {
        case .muslimWorldLeague:
            return NSLocalizedString("Muslim World League", comment: "")
        case .egyptian:
            return NSLocalizedString("Egyptian", comment: "")
        case .karachi:
            return NSLocalizedString("Karachi", comment: "")
        case .ummAlQura:
            return NSLocalizedString("Umm Al-Qura", comment: "")
        case .dubai:
            return NSLocalizedString("Dubai", comment: "")
        case .moonsightingCommittee:
            return NSLocalizedString("Moonsighting Committee", comment: "")
        case .northAmerica:
            return NSLocalizedString("North America (ISNA)", comment: "")
        case .kuwait:
            return NSLocalizedString("Kuwait", comment: "")
        case .qatar:
            return NSLocalizedString("Qatar", comment: "")
        case .singapore:
            return NSLocalizedString("Singapore", comment: "")
        case .tehran:
            return NSLocalizedString("Tehran", comment: "")
        case .turkey:
            return NSLocalizedString("Turkey", comment: "")
        case .other:
            return NSLocalizedString("Other", comment: "")
        }
    }
}
