import Foundation

class Converter {
    static func formAgeString(years: Int, months: Int) -> String {
        var result = ""
        
        switch years {
        case 1:
            result += "\(years) год "
        case 2...4:
            result += "\(years) годa "
        default:
            result += "\(years) лет "
        }
        
        
        switch months {
        case 1:
            result += "\(months) месяц"
        case 2...4:
            result += "\(months) месяца"
        default:
            result += "\(months) месяцев"
        }
        
        return result
    }

    static func formTimeString(hours: Int, minutes: Int) -> String {
        var result = ""
        
        switch hours {
        case 1:
            result += "\(hours) час "
        case 2...4:
            result += "\(hours) часа "
        case 5...12:
            result += "\(hours) часов "
        default:
            result += ""
        }
        
        result += "\(minutes) \(convertMinutes(min: minutes, forms: ["минута", "минуты", "минут"]))"
        
        return result
    }

    static func convertMinutes(min: Int, forms: [String]) -> String {
        let n = min % 100
        let n1 = n % 10
        if (n > 10 && n < 20) { return forms[2] }
        if (n1 > 1 && n1 < 5) { return forms[1] }
        if (n1 == 1) { return forms[0] }
        return forms[2]
    }

    static func timeStringToMinutes(time: String) -> Int {
        let t = time.split(separator: ":")
        if t.count < 2 {
            return 0
        }
        return (Int(t[0]) ?? 0) * 60 + (Int(t[1]) ?? 0)
    }

    static func minutesToString(_ totalMinutes: Int) -> String {
        let tmp = getHoursAndMinutesFromString(totalMinutes: totalMinutes)
        return "\(String(format: "%02d",tmp.hours)):\(String(format: "%02d", tmp.minutes))"
    }

    static func getHoursAndMinutesFromString(totalMinutes: Int) -> (hours: Int, minutes: Int) {
        let hours = totalMinutes / 60
        let minutes = totalMinutes - hours * 60
        return (hours: hours, minutes: minutes)
    }
    
    static func convertBirthdayToAge(birthday: String) -> String {
        let secondsInYear = Double(86400 * 365)
        let secondsInMonth = Double(86400 * 30)
        let currEpoch = NSDate().timeIntervalSince1970
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yyyy"
        let date = dateFormatter.date(from: birthday)?.timeIntervalSince1970 ?? 0
        let diffInSeconds = currEpoch - date
        let years = Int(diffInSeconds / secondsInYear)
        let months = Int((diffInSeconds - (Double(years) * secondsInYear)) / secondsInMonth)
        let result = Converter.formAgeString(years: years, months: months)
        return result
    }
}

class Constants {
    static let onboardingTexts = [
        "Расскажите нам о своих детях, чтобы мы могли предложить рекомендуемый режим сна для них",
        "Для ребенка возрастом от 1 года, мы рекомендуем такой распорядок дня, но вы можете отредактировать его:",
        "Мы поможем вам укладывать ребенка спать с помощью подборки успокаивающих звуков, советов и подсказок"
    ]
}
