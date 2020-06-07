package ru.hh.cphelper;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.cphelper.resource.CompetitorsResource;
import ru.hh.cphelper.resource.DayReportResource;
import ru.hh.cphelper.resource.EmployerCompareResource;
import ru.hh.cphelper.resource.TrackedEmployersResource;

@Configuration
@Import({
    CompetitorsResource.class,
    DayReportResource.class,
    EmployerCompareResource.class
    TrackedEmployersResource.class,
})
public class CpHelperJerseyConfig {
}
