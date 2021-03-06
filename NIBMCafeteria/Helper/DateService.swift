//
//  DateService.swift
//  NIBMCafeteria
//
//  Created by Sathsara Maduranga on 2021-03-04.
//

import Foundation

struct DateTime {
    var date:Date
    var time:Date
}

enum DateFormat: String {
    
    case FullDateTime_WithDash_24Hours_yMd = "yyyy-MM-dd HH:mm:ss"
    case FullDateTime_WithDash_24Hours_dMy = "dd-MM-yyyy HH:mm:ss"
    case FullDateTime_WithDash_24Hours_yMdS = "yyyy-MM-dd HH:mm:ss.S"
    case FullDateTime_WithSlash_24Hours_yMd = "yyyy/MM/dd HH:mm:ss"
    case FullDateTime_WithSlash_24Hours_dMy = "dd/MM/yyyy HH:mm:ss"
    case FullDateTime_WithDash_12Hours_yMd = "yyyy-MM-dd hh:mm:ss a"
    case FullDateTime_WithDash_12Hours_dMy = "dd-MM-yyyy hh:mm:ss a"
    case FullDateTime_WithSlash_12Hours_yMd = "yyyy/MM/dd hh:mm:ss a"
    case FullDateTime_WithSlash_12Hours_dMy = "dd/MM/yyyy hh:mm:ss a"
    case Date_WithDash_yMd = "yyyy-MM-dd"
    case Date_WithDash_ddMMMdd = "dd-MMM-yyyy"
    case Date_WithDash_dMy = "dd-MM-yyyy"
    case Date_WithSlash_yMd = "yyyy/MM/dd"
    case Date_WithSlash_dMy = "dd/MM/yyyy"
    case Date_WithSpace_yMd = "yyyy MM dd"
    case Date_WithSpace_dMy = "dd MM yyyy"
    case Date_WithSpace_dSMy = "dd MMM yyyy"
    case Date_WithSpace_dLMy = "dd MMMM yyyy"
    case Date_WithSpace_ySMd = "yyyy MMM dd"
    case Date_WithSpace_yLMd = "yyyy MMMM dd"
    case FullDateTime_day_dLMy_24Hours = "EEEE, d MMMM yyyy HH:mm"
    case FullDateTime_day_dLMy_12Hours = "EEEE, d MMMM yyyy hh:mm a"
    case FullDateTime_day_dLMy_24Hours_Z = "EEEE, d MMMM yyyy HH:mm Z"
    case FullDateTime_day_dMy_24Hours = "EEEE, dd/MM/yyyy HH:mm"
    case ShortDate_dSMy = "d MMM yyyy"
    case Time_24Hours = "HH:mm:ss"
    case Time_12Hours_hmsx = "h:mm:ss a"
    case Time_12Hours_hmx = "hh:mm aa"
    case Time_12Hours_hm_WithSpace_ymd = "h:mm a- yyyyMMMdd"
    case Date_WithSpace_numeric = "yyyy mm dd"
}

extension String {
    // Convert String to Date
    func convertStringToDate(_ formatString: DateFormat) -> Date {
        let formatter = DateFormatter() // Create Time Formatter
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = formatString.rawValue // Specify Format of Date to Parse
        let dateFromString:Date = formatter.date(from: self) ?? Date() // Parse into Date
        return dateFromString // Return Parsed Date
    }
    
    func getDateTimeFromString(_ formatDateTimeString: DateFormat, _ formatDateString: DateFormat, _ formatTimeString: DateFormat) -> DateTime {
        let longDateTime:Date = self.convertStringToDate(formatDateTimeString) as Date
        
        let shortDateString:String = longDateTime.convertDateToString(formatDateString)
        let shortDate:Date = shortDateString.convertStringToDate(formatDateString) as Date
        
        let timeString:String = longDateTime.convertDateToString(formatTimeString)
        let time:Date = timeString.convertStringToDate(formatTimeString)
        
        let dateTime = DateTime(date: shortDate, time: time)
        return dateTime
    }
}

extension Date {
    // Convert Date to String
    func convertDateToString(_ formatString: DateFormat) -> String {
        let formatter = DateFormatter() // Create Date Formatter
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = formatString.rawValue // Specify Format of String to Parse
        let stringFromDate:String = formatter.string(from: self) as String  // Parse into String
        return stringFromDate // Return Parsed String
    }
    
    // Manage display day
    func manageDisplayDate() -> String {
        let calendar = Calendar.current
        if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInTomorrow(self) {
            return "Tomorrow"
        } else {
            return self.convertDateToString(.Date_WithSlash_dMy)
        }
    }
}
