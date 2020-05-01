package ru.hh.cphelper;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.cphelper.resource.CompetitorsResource;
import ru.hh.cphelper.resource.DayReportResource;

@Configuration
@Import({
    CompetitorsResource.class,
    DayReportResource.class
})
public class CpHelperJerseyConfig {
}
