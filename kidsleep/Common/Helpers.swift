import Foundation

func formAgeString(years: Int, months: Int) -> String {
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

func formTimeString(hours: Int, minutes: Int) -> String {
    var result = ""
    
    switch hours {
    case 1:
        result += "\(hours) час "
    case 2...4:
        result += "\(hours) часа "
    case 5...12:
        result += "\(hours) часов"
    default:
        result += ""
    }
    
    switch minutes % 10 {
    case 0:
        result += "\(minutes) минут"
    case 1:
        result += "\(minutes) минута"
    case 2...4:
        result += "\(minutes) минуты"
    case 5...9:
        result += "\(minutes) минут"
    default:
        result += ""
    }
    
    return result
}

func timeStringToMinutes(time: String) -> Int {
    let t = time.split(separator: ":")
    return (Int(t[0]) ?? 0) * 60 + (Int(t[1]) ?? 0)
}
