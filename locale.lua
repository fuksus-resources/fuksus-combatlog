Locales = {}

function L(str, ...) -- Translate string
    if not str then
        print(('[^6%s^7] [^8ERROR^7] You did not specify a parameter for the Translate function or the value is nil!'):format(GetInvokingResource() or GetCurrentResourceName()))
        return "Given translate function parameter is nil!"
    end
    if Locales[Config.Locale] then
        if Locales[Config.Locale][str] then
            return string.format(Locales[Config.Locale][str], ...)
        elseif Config.Locale ~= "en" and Locales["en"] and Locales["en"][str] then
            return string.format(Locales["en"][str], ...)
        else
            return "Translation [" .. Config.Locale .. "][" .. str .. "] does not exist"
        end
    elseif Config.Locale ~= "en" and Locales["en"] and Locales["en"][str] then
        return string.format(Locales["en"][str], ...)
    else
        return "Locale [" .. Config.Locale .. "] does not exist"
    end
end

function GetLocales()
    return Locales[Config.Locale]
end