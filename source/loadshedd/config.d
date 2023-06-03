module loadshedd.config;

import std.json : JSONValue, JSONException;
import jstruct;

public struct Config
{
    public string server;
    public string area;
    public long warnBefore;
    public long refreshInterval;

    public static fromJSON2(JSONValue json)
    {
        return fromJSON!(Config)(json);
    }
}

version(unittest)
{
    import std.json : parseJSON;
    import std.stdio;
}

unittest
{
    JSONValue testConfig = parseJSON(`
    {
        "server": "https://eskom-calendar-api.shuttleapp.rs/v0.0.1/",
        "area": "western-cape-worscester",
        "warnBefore": 1,
        "refreshInterval" : 1
    }
    `);

    Config config = Config.fromJSON2(testConfig);
    writeln(config);

}