-- Global variables for luakit
globals = {
    homepage            = "about:blank",
    scroll_step         = 40,
    zoom_step           = 0.1,
    max_cmd_history     = 100,
    max_srch_history    = 100,
 -- http_proxy          = "http://example.com:3128",
    default_window_size = "800x600",
    useragent           = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17"
 -- Disables loading of hostnames from /etc/hosts (for large host files)
 -- load_etc_hosts      = false,
 -- Disables checking if a filepath exists in search_open function
 -- check_filepath      = false,
}

-- Search common locations for a ca file which is used for ssl connection validation.
local ca_files = {
    -- $XDG_DATA_HOME/luakit/ca-certificates.crt
    luakit.data_dir .. "/ca-certificates.crt",
    "/etc/certs/ca-certificates.crt",
    "/etc/ssl/certs/ca-certificates.crt",
}
-- Use the first ca-file found
for _, ca_file in ipairs(ca_files) do
    if os.exists(ca_file) then
        soup.ssl_ca_file = ca_file
        break
    end
end

-- Change to stop navigation sites with invalid or expired ssl certificates
soup.ssl_strict = false

-- Set cookie acceptance policy
cookie_policy = { always = 0, never = 1, no_third_party = 2 }
soup.accept_policy = cookie_policy.always

-- List of search engines. Each item must contain a single %s which is
-- replaced by URI encoded search terms. All other occurances of the percent
-- character (%) may need to be escaped by placing another % before or after
-- it to avoid collisions with lua's string.format characters.
-- See: http://www.lua.org/manual/5.1/manual.html#pdf-string.format
search_engines = {
    dd = "https://duckduckgo.com/?q=%s",
    gh = "https://github.com/search?q=%s",
    g = "https://google.com/search?q=%s",
    imdb = "http://www.imdb.com/find?s=all&q=%s",
    w = "https://en.wikipedia.org/wiki/Special:Search?search=%s",
    hn = "https://www.google.se/search?q=site:news.ycombinator.com+%s",
    jq = "http://api.jquery.com/?s=%s",
    hg = "http://www.haskell.org/hoogle/?hoogle=%s",
    njs = "https://www.google.se/search?q=site:nodejs.org/api+%s&btnI=I",
    cmp = "http://compass-style.org/search/?q=%s",
    rwh = "https://www.google.se/search?q=site:book.realworldhaskell.org/read+%s&btnI=I",
    lyh = "https://www.google.se/search?q=site:http://learnyouahaskell.com+%s&btnI=I",
}

-- Set google as fallback search engine
search_engines.default = search_engines.g
-- Use this instead to disable auto-searching
--search_engines.default = "%s"

-- Per-domain webview properties
-- See http://webkitgtk.org/reference/webkitgtk/stable/WebKitWebSettings.html
domain_props = { --[[
    ["all"] = {
        enable_scripts          = false,
        enable_plugins          = false,
        enable_private_browsing = false,
        user_stylesheet_uri     = "",
    },
    ["youtube.com"] = {
        enable_scripts = true,
        enable_plugins = true,
    },
    ["bbs.archlinux.org"] = {
        user_stylesheet_uri     = "file://" .. luakit.data_dir .. "/styles/dark.css",
        enable_private_browsing = true,
    }, ]]
}

-- vim: et:sw=4:ts=8:sts=4:tw=80
