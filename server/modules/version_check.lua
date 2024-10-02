local function checkVersion()
    local resource = GetInvokingResource() or GetCurrentResourceName()

	local currentVersion = GetResourceMetadata(resource, 'version', 0)

    if currentVersion then
        currentVersion = currentVersion:match('%d+%.%d+%.%d+')
    end

    if not currentVersion then return print(("[^6%s^7] [^8ERROR^7] Unable to determine current resource version for '%s' ^0"):format(resource, resource)) end

    SetTimeout(1000, function()
        PerformHttpRequest(('https://api.github.com/repos/fuksus-resources/%s/releases/latest'):format(resource), function(status, response)
            if status ~= 200 then
                if status == 404 then
                    return print(("[^6%s^7] [^8ERROR^7] Unable to check for updates for '%s' did you rename the resource ? ^0"):format(resource, resource))
                end
                return
            end

			response = json.decode(response)
			if response.prerelease then return end

			local latestVersion = response.tag_name:match('%d+%.%d+%.%d+')
			if not latestVersion or latestVersion == currentVersion then return end

            local cv = { string.strsplit('.', currentVersion) }
            local lv = { string.strsplit('.', latestVersion) }

            for i = 1, #cv do
                local current, minimum = tonumber(cv[i]), tonumber(lv[i])

                if current ~= minimum then
                    if current < minimum then
                        print('^8--------------------^7[^5INFO^7]^8-----------------')
                        print(('^3An update is available for %s (current version: %s)\r\n%s^0'):format(resource, currentVersion, 'Get the latest version at https://github.com/fuksus-resources/fuksus-combatlog/releases'))
                        print('^8--------------------------------------------^7')
                        return
                    else break end
                end
            end
        end, 'GET', '', {
            ['Accept'] = 'application/vnd.github+json'
        })
    end)
end

return checkVersion
