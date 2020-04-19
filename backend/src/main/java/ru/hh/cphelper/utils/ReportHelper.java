package ru.hh.cphelper.utils;

import ru.hh.cphelper.dto.ReportResponseDto;
import ru.hh.cphelper.entity.Report;

import java.util.List;
import java.util.stream.Collectors;

public final class ReportHelper {

    private ReportHelper() {
    }

    public static List<ReportResponseDto> map(List<Report> reports){
        return reports.stream()
                .map(r -> new ReportResponseDto(r.getEmployerId(), r.getServiceId(),
                        r.getServiceName(), r.getServiceQuantity(),
                        r.getResponseQuantity(), r.getServiceOrderDate()))
                .collect(Collectors.toList());
    }
}
