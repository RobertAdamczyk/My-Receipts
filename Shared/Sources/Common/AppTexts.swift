//
//  AppTexts.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 10.08.23.
//

import Foundation

enum AppText {

    case generic(Generic)
    case home(Home)
    case addReceipt(AddReceipt)
    case dialogApp(DialogApp)
    case sortBy(SortBy)
    case settings(Settings)
    case imagePreview(ImagePreview)

    var value: String {
        switch self {
        case .generic(let generic): return generic.rawValue
        case .home(let home): return home.rawValue
        case .addReceipt(let addReceipt): return addReceipt.rawValue
        case .dialogApp(let dialogApp): return dialogApp.rawValue
        case .sortBy(let sortBy): return sortBy.rawValue
        case .settings(let settings): return settings.rawValue
        case .imagePreview(let imagePreview): return imagePreview.rawValue
        }
    }

    enum Generic: String {
        case categories = "generic_categories"
        case warranty = "generic_warranty"
        case saveButton = "generic_save"
        case receipts = "generic_receipts"
        case purchaseDate = "generic_purchase_date"
        case title = "generic_title"
        case informations = "generic_informations"
        case edit = "generic_edit"
        case delete = "generic_delete"
        case cancel = "generic_cancel"
        case newCategory = "generic_new_category"
        case symbol = "generic_symbol"
        case enter = "generic_enter"
        case version = "generic_version"
        case notificationBody = "generic_notification_body"
        case ok = "Ok"
        case saved = "Saved"
    }

    enum Home: String {
        case defaultCategory = "home_default_category"
        case firstLetterDefaultCategory = "home_default_first_letter_category"
    }

    enum AddReceipt: String {
        case purchaseSection = "add_receipt_purchase"
        case newReceiptTitle = "add_receipt_title"
        case editReceiptTitle = "edit_receipt_title"
        case loadImage = "add_receipt_load_image"
        case categoryHint = "add_receipt_category_hint"
        case warrantyHint = "add_receipt_warranty_hint"
        case endWarranty = "add_receipt_end_warranty"
    }

    enum DialogApp: String {
        case image = "dialog_app_image"
        case useExisting = "dialog_app_use_existing"
        case takePhoto = "dialog_app_take_photo"
    }

    enum SortBy: String {
        case title = "sort_title"
        case titleAscending = "sort_title_ascending"
        case titleDescending = "sort_title_descending"
        case purchaseAscending = "sort_purchase_ascending"
        case purchaseDescending = "sort_purchase_descending"
        case warrantyDescending = "sort_warranty_descending"
        case warrantyAscending = "sort_warranty_ascending"
    }

    enum Settings: String {
        case title = "settings_title"
        case generalSection = "settings_general"
        case appSection = "settings_app"
        case notifications = "settings_notifications"
        case notificationsHint = "settings_notifications_hint"
        case notificationsHintHightlighted = "settings_go_to"
        case notificationsToggle = "settings_notifications_enable"
        case notificationsOptions = "settings_notifications_options"
        case notificationNotifyMe = "settings_notifications_notify_me"
        case notificationsDaysHint = "settings_notifications_days_hint"
        case emptyCategories = "settings_empty_categories"
        case aboutCreatedBy = "settings_created_by"
        case aboutThankYou = "settings_thank_you"
    }

    enum ImagePreview: String {
        case permissionErrorTitle = "You haven't allowed this app to save photos."
        case permissionErrorMessage = "You can enable this functionality in phone Settings."
    }
}

func appText(_ appText: AppText, args: String...) -> String {

    var originalString = NSLocalizedString(appText.value,
                                           tableName: "Localizable",
                                           bundle: .main,
                                           value: appText.value,
                                           comment: appText.value)

    args.forEach { arg in
        if let range = originalString.range(of: "%s") {
            originalString.replaceSubrange(range, with: arg)
        } else {
            assertionFailure("To nie powinno sie wydarzyc. Twoj klucz nie ma %s lub nie powinienes uzywac argumentow z tym kluczem.")
        }
    }
    return originalString
}
