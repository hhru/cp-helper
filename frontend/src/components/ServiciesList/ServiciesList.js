import React from 'react';
import PropTypes from 'prop-types';
import {useSelector} from 'react-redux';
import './ServiciesList.css';

const Service = ({profAreas, service, rowspan, firstRow}) => {
    const {employerId, serviceName, serviceAreaId, serviceProfArea, spendingCount, responseCount, responsePerService} = service;
    return (
    <tr>
        {firstRow && (
        <td rowSpan={rowspan}>
            {employerId}
        </td>
        )}
        <td>
            {serviceName}
        </td>
        <td>
            {serviceAreaId}
        </td>
        <td>
            {profAreas[serviceProfArea]}
        </td>
        <td>
            {spendingCount}
        </td>
        <td>
            {responseCount}
        </td>
        <td>
            {responsePerService}
        </td>
    </tr>
    );
};

Service.propTypes = {
    service: PropTypes.object,
    profAreas: PropTypes.object,
    rowspan: PropTypes.number,
    firstRow: PropTypes.boolean,
};

const ServiciesList = ({ services }) => {
    const profAreas = useSelector((state) => state.profAreas.profAreas);

    return (
        <table className="hh-table">
            <thead className="hh-table__head">
            <tr>
                <td>
                    Работодатель
                </td>
                <td>
                    Код услуги
                </td>
                <td>
                    Регион
                </td>
                <td>
                    Проф. область
                </td>
                <td>
                    Количество трат
                </td>
                <td>
                    Количество откликов
                </td>
                <td>
                    Отклик/трата
                </td>
            </tr>
            </thead>
            <tbody className="hh-table__body">
                {Object.entries(services).map((employer) => (
                    employer[1].map((service, index) => (
                        <Service
                            key={service.serviceName + service.employerId}
                            service={service}
                            profAreas={profAreas}
                            rowspan={employer[1].length}
                            firstRow={index === 0} />
                    ))))}
            </tbody>
        </table>
    );
};

ServiciesList.defaultProps = {
    services: {
    "1870": [
        {
        "employerId": 1870,
        "serviceCode": 27,
        "serviceName": "Left block advert",
        "serviceAreaId": 70,
        "serviceProfArea": 1,
        "spendingCount": 2,
        "responseCount": 10,
        "responsePerService": 5,
        },
        {
        "employerId": 1870,
        "serviceCode": 25,
        "serviceName": "Footer advert",
        "serviceAreaId": 70,
        "serviceProfArea": 20,
        "spendingCount": 17,
        "responseCount": 10,
        "responsePerService": 0.588,
        },
    ],
    "1455": [
        {
        "employerId": 1455,
        "serviceCode": 22,
        "serviceName": "Access to the resume database",
        "serviceAreaId": 70,
        "serviceProfArea": 20,
        "spendingCount": 101,
        "responseCount": 40,
        "responsePerService": 0.396,
        },
    ],
}};

ServiciesList.propTypes = {
    services: PropTypes.object,
    profAreas: PropTypes.object,
};

export default ServiciesList;
