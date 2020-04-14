package ru.hh.cphelper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.MockitoJUnitRunner;
import org.springframework.test.context.ContextConfiguration;
import ru.hh.cphelper.dao.CompetitorsDao;
import ru.hh.cphelper.entity.Competitor;
import ru.hh.cphelper.service.CompetitorsService;
import ru.hh.nab.testbase.NabTestBase;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.ArgumentMatchers.isA;
import static org.mockito.Mockito.doNothing;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;

@ContextConfiguration(classes = CpHelperTestConfig.class)
@RunWith(MockitoJUnitRunner.class)
public class CompetitorsServiceTest extends NabTestBase {

    @Mock
    private CompetitorsDao competitorsDaoMock;

    @Mock
    Competitor competitorMock;

    @InjectMocks
    private CompetitorsService competitorsService;

    @Test
    public void addCompetitorExists() {
        when(competitorsDaoMock.find(isA(Competitor.class))).thenReturn(competitorMock);
        competitorsService.add(competitorMock);
        verify(competitorsDaoMock, times(0)).save(any());
    }

    @Test
    public void addCompetitorNotExist() {
        when(competitorsDaoMock.find(isA(Competitor.class))).thenReturn(null);
        doNothing().when(competitorsDaoMock).save(isA(Competitor.class));
        competitorsService.add(competitorMock);
        verify(competitorsDaoMock, times(1)).save(isA(Competitor.class));
    }

    @Test
    public void deleteCompetitorExists() {
        when(competitorsDaoMock.find(isA(Competitor.class))).thenReturn(competitorMock);
        doNothing().when(competitorsDaoMock).delete(isA(Competitor.class));
        competitorsService.delete(competitorMock);
        verify(competitorsDaoMock, times(1)).delete(isA(Competitor.class));
    }

    @Test
    public void deleteCompetitorNotExist() {
        when(competitorsDaoMock.find(isA(Competitor.class))).thenReturn(null);
        competitorsService.delete(competitorMock);
        verify(competitorsDaoMock, times(0)).delete(any());
    }

}
