package ru.hh.cphelper;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.cphelper.resource.CompetitorsResource;

@Configuration
@Import({
    CompetitorsResource.class
})
public class CpHelperJerseyConfig {
}
