//
//  Localizator.swift
//  Copyright © 2019 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

public class Localizator {
    fileprivate func NSLocalizedString(_ key: String) -> String {
        return Foundation.NSLocalizedString(key, comment: "")
    }
}

extension String {
    // Unwind Segue Identifiers
    
    // Navigation bar titles
    
    // Loader messages
    static let Login = NSLocalizedString("Login...", comment: "")
    static let Registering = NSLocalizedString("Registering...", comment: "")
    static let Logout = NSLocalizedString("Logout...", comment: "")
    static let Loading = NSLocalizedString("Loading...", comment: "")
    
    // File extensions
    static let PDF = NSLocalizedString("pdf", comment: "")
    static let HTML = NSLocalizedString("html", comment: "")
    static let DOCX = NSLocalizedString("docx", comment: "")
    static let PNG = NSLocalizedString("png", comment: "")
    
    
    static let Document = NSLocalizedString("Document", comment: "")
    static let Location = NSLocalizedString("Location", comment: "")
    static let Contact = NSLocalizedString("Contact", comment: "")
    
    // Nibs
    
    // Alert titles
    static let Alert = NSLocalizedString("Alert", comment: "")
    static let Confirmation = NSLocalizedString("Confirmation", comment: "")
    static let Error = NSLocalizedString("Error", comment: "")
    static let Incomplete = NSLocalizedString("Incomplete", comment: "")
    static let Success = NSLocalizedString("Success", comment: "")
    static let Failed = NSLocalizedString("Failed", comment: "")
    static let Oops = NSLocalizedString("Oops", comment: "")
    static let Warning = NSLocalizedString("Warning", comment: "")
    static let ResetEmailSent = NSLocalizedString("A password reset link has been sent. Please check your email.", comment: "")
    static let SomethingWentWrong = NSLocalizedString("Something went wrong.", comment: "")
    
    // Failure messages
    static let MisingData = NSLocalizedString("Missing data in the request.", comment: "")
    static let ServerErrorOccurred = NSLocalizedString("Server error occurred. Please try again later.", comment: "")
    static let UnknownErrorOccurred = NSLocalizedString("Unknown error occurred. Please try again later.", comment: "")
    static let FailedToFetchUser = NSLocalizedString("Failed to fetch user. Please try again.", comment: "")
    static let UserNotEligibleForMessaging = NSLocalizedString("The selected user is not eligible for messaging.", comment: "")
    static let FailedDeleteConversation = NSLocalizedString("Failed to delete the conversation.", comment: "")
    
    // ALERT MESSAGES
    // Local error messages
    static let ErrorCorrupted = NSLocalizedString("Error is corrupted.", comment: "")
    static let MissingData = NSLocalizedString("Missing data in the request.", comment: "")
    static let AnyFieldEmpty = NSLocalizedString("All fields are required.", comment: "")
    static let MissingRequiredFields = NSLocalizedString("Missing some required fields.", comment: "")
    static let NameEmpty = NSLocalizedString("Please enter name.", comment: "")
    static let FirstNameEmpty = NSLocalizedString("Please enter firstname.", comment: "")
    static let LastNameEmpty = NSLocalizedString("Please enter lastname.", comment: "")
    static let OccupationNotPicked = NSLocalizedString("Please select occupation.", comment: "")
    static let AnyPasswordEmpty = NSLocalizedString("Please fill both password fields.", comment: "")
    static let EmailEmpty = NSLocalizedString("Please enter email address.", comment: "")
    static let PasswordEmpty = NSLocalizedString("Please enter password.", comment: "")
    static let PhoneEmpty = NSLocalizedString("Please enter phone number.", comment: "")
    static let InvalidEmail = NSLocalizedString("Invalid email address.", comment: "")
    static let InvalidPhone = NSLocalizedString("Invalid phone number.", comment: "")
    static let InvalidUrl = NSLocalizedString("Invalid url.", comment: "")
    static let InvalidPassword = NSLocalizedString("Invalid password.", comment: "")
    static let ShorterPassword = NSLocalizedString("Password should be at least \\(Constant.Counts.passwordCount) characters.", comment: "")
    static let MismatchingPasswords = NSLocalizedString("Passwords do not match.", comment: "")
    static let NoCameraPermission = NSLocalizedString("No camera permission set.", comment: "")
    static let CurrentPasswordEmpty = NSLocalizedString("Please enter current password.", comment: "")
    static let NewPasswordEmpty = NSLocalizedString("Please enter new password.", comment: "")
    static let ConfirmPasswordEmpty = NSLocalizedString("Please enter confirm password.", comment: "")
    static let newCurrentMatchPasswords = NSLocalizedString("Current password and new password can not be same.", comment: "")
    static let RetryMessage = NSLocalizedString("Failed to upload profile picture. Please try again.", comment: "")
    static let SuccessfullyUpdated = NSLocalizedString("Profile updated successfully.", comment: "")
    static let SubjectMissing = NSLocalizedString("Please enter subject", comment: "")
    static let MessageMissing = NSLocalizedString("Please enter message", comment: "")
    static let MissingQuestion = NSLocalizedString("Please enter Question", comment: "")
    static let InternetConnectionOffline = NSLocalizedString("Internet connection appears to be offline. ", comment: "")
    static let openTermsCondition = NSLocalizedString("Read \"Terms & Conditions\" befor signup.", comment: "")
    
    // Success messages
    
    // Failure messages
    
    // No data messages
    
    // Info messages
    static let FeatureNotImplemented = NSLocalizedString("This feature is not implemented.", comment: "")
    
    // Confirmation messages
    static let LogoutConfirmation = NSLocalizedString("Are you sure you want to logout?", comment: "")
    
    // Action titles
    static let Ok = NSLocalizedString("OK", comment: "")
    static let Cancel = NSLocalizedString("Cancel", comment: "")
    static let Yes = NSLocalizedString("Yes", comment: "")
    static let No = NSLocalizedString("No", comment: "")
    static let Retry = NSLocalizedString("Retry", comment: "")
    static let Dismiss = NSLocalizedString("Dismiss", comment: "")
    static let Call = NSLocalizedString("Call", comment: "")
    static let Settings = NSLocalizedString("Settings", comment: "")
    static let Continue = NSLocalizedString("Continue", comment: "")
    static let Create = NSLocalizedString("Create", comment: "")
    static let Add = NSLocalizedString("Add", comment: "")
    static let Update = NSLocalizedString("Update", comment: "")
    static let Delete = NSLocalizedString("Delete", comment: "")
    static let Skip = NSLocalizedString("Skip", comment: "")
    
    static let TakePhoto = NSLocalizedString("Take Photo", comment: "")
    static let ChooseFromLibrary = NSLocalizedString("Choose from Library", comment: "")
    
    // Placeholders
    
    // Other
    static let NotApplicable = NSLocalizedString("N/A", comment: "")
    static let LineBreak = NSLocalizedString("\n", comment: "")
    static let QuestionMark = NSLocalizedString("?", comment: "")
    static let SingleQotation = NSLocalizedString("'", comment: "")
    static let EmptyString = NSLocalizedString("", comment: "")
    
    // Storyboard identifiers
    
    // ViewControllers
    static let LoginVC = NSLocalizedString("LoginVC", comment: "")
    static let SignupVC = NSLocalizedString("SignupVC", comment: "")
    static let ForgotPasswordVC = NSLocalizedString("ForgotPasswordVC", comment: "")
    static let EditProfileVC = NSLocalizedString("EditProfileVC", comment: "")
    static let ChangePasswordVC = NSLocalizedString("ChangePasswordVC", comment: "")
    static let AppDetailsVC = NSLocalizedString("AppDetailsVC", comment: "")
    static let HomeVC = NSLocalizedString("HomeVC", comment: "")
    static let DetailsVC = NSLocalizedString("DetailsVC", comment: "")
    static let SellerSignupVC = NSLocalizedString("SellerSignupVC", comment: "")
    static let UserTypeSelectionVC = NSLocalizedString("UserTypeSelectionVC", comment: "")
    static let PaymentRequestVC = NSLocalizedString("PaymentRequestVC", comment: "")
    static let AddPaymentMethodVC = NSLocalizedString("AddPaymentMethodVC", comment: "")
    static let UserConfirmationVC = NSLocalizedString("UserConfirmationVC", comment: "")
    static let CustomAlertVC = NSLocalizedString("CustomAlertVC", comment: "")
    static let AboutUsVC = NSLocalizedString("AboutUsVC", comment: "")
    
    
    // ViewControllers
    static let RegisterVC = NSLocalizedString("RegisterVC", comment: "")
    static let LoginVc = NSLocalizedString("LoginVc", comment: "")
    static let RetrievePasswordVC = NSLocalizedString("RetrievePasswordVC", comment: "")
    static let MainVC = NSLocalizedString("MainVC", comment: "")
    static let ConversationsVC = NSLocalizedString("ConversationsVC", comment: "")
    static let MessagesVC = NSLocalizedString("MessagesVC", comment: "")
    static let UsersVC = NSLocalizedString("UsersVC", comment: "")
    static let MediaViewerVC = NSLocalizedString("MediaViewerVC", comment: "")
    static let HistoryVC = NSLocalizedString("HistoryVC", comment: "")
    static let PayementMethodVC = NSLocalizedString("PayementMethodVC", comment: "")
    static let StripAccountVC = NSLocalizedString("StripAccountVC", comment: "")
    static let PaymentGetwayVC = NSLocalizedString("PaymentGetwayVC", comment: "")
    static let ChoosePlanVC = NSLocalizedString("ChoosePlanVC", comment: "")
    static let LocationAccesssVC = NSLocalizedString("LocationAccessVC", comment: "")


    

    

    

    

    

    // No data messages
    
    // Info messages
    
    // Confirmation messages
    static let RemoveConversationConfirmation = NSLocalizedString("Are you sure you want to delete this conversation?", comment: "")
    

    
    // Top viewController of the Storyboard
    static let AuthNC = NSLocalizedString("AuthNC", comment: "")
    static let HomeNC = NSLocalizedString("HomeNC", comment: "")
    static let SideMenuConfigurationVC = NSLocalizedString("SideMenuConfigurationVC", comment: "")
    static let MainTBC = NSLocalizedString("MainTBC", comment: "")
    static let GuestTabBarController = NSLocalizedString("GuestTabBarController", comment: "")
    
    
    // Error messages with API
    
}

extension UIImage {
    
}

extension UIColor {
    
    static let buttonLightColor = UIColor(red:0.33, green:0.77, blue:0.82, alpha:1)
    static let buttonDarkColor = UIColor(red:0.27, green:0.65, blue:0.69, alpha:1)
}
