package ru.hh.cphelper;

import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import ru.hh.cphelper.resource.CompetitorsResource;
import ru.hh.cphelper.resource.ExampleResource;

@Configuration
@Import({ExampleResource.class, CompetitorsResource.class})
public class CpHelperJerseyConfig {
}
