module loadshedd.app;

import loadshedd.config;
import std.stdio;
import eskomcalendar;
import core.thread : Thread, dur, Duration;
import std.datetime.systime : Clock, SysTime;

void main()
{
	Config config = Config.fromJSON2(getJSON("config.json"));
    EskomCalendar calendar = new EskomCalendar(config.server);

    while(true)
    {
        // Get schedules for your area today
        Schedule[] todayShedding = calendar.getTodaySchedules(config.area);
        writeln("Schedules for today:\n");

        Schedule[] careAbouts;
        foreach(Schedule schedule; todayShedding)
        {
            writeln(schedule);

            SysTime currentTime = Clock.currTime();
            currentTime += dur!("minutes")(config.warnBefore);

            // TODO: Figure out the algo
            
          
        }

        writeln("End of schedules");

        writeln("Care abouts: ", careAbouts);


        Thread.sleep(dur!("minutes")(config.refreshInterval));
    }
}

import std.json : parseJSON, JSONValue;
private JSONValue getJSON(string path)
{
    // JSONValue jsonConfig;

    File configFile;
    configFile.open(path);

    byte[] data;
    data.length = configFile.size();
    configFile.rawRead(data);
    configFile.close();

    return parseJSON(cast(string)data);
}
