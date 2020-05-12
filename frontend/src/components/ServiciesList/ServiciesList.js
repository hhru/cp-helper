import React, {useState} from 'react';
import PropTypes from 'prop-types';
import {useSelector} from 'react-redux';

import './ServiciesList.css';
import Service from './Service';

const ServiciesList = ({ services, competitors, companyName, companyId, plainAreas }) => {

    const profAreas = useSelector((state) => state.profAreas.profAreas);
    const [selectedServices, setSelectedServices] = useState([]);
    const addService = (serviceName) => {
        setSelectedServices([...selectedServices, serviceName]);
    };

    const getEmployerName = (id) => {
        if (`${id}` === companyId) {
            return companyName;
        }
        return competitors && competitors[id] && competitors[id].name;
    };

    const COLUMN_NAMES = ['Работодатель', 'Код услуги', 'Регион', 'Проф. область', 'Количество трат', 'Количество откликов', 'Отклик/трата'];

    return (
        <>
        <table className="hh-table">
            <thead className="hh-table__head">
            <tr>
                {COLUMN_NAMES.map((name) => (
                    <td key="name">
                        {name}
                    </td>
                ))}
                <td/>
            </tr>
            </thead>
            <tbody className="hh-table__body">
                {services ? Object.entries(services).map((employer) => (
                    employer[1].map((service, index) => (
                        <Service
                            employerName={getEmployerName(service.employerId)}
                            areaName={plainAreas && plainAreas[service.serviceAreaId].name}
                            profareaName={profAreas && profAreas[service.serviceProfArea].name}
                            key={service.serviceName + service.employerId}
                            service={service}
                            rowspan={employer[1].length}
                            firstRow={index === 0}
                            addService={addService}
                            disabledAddService={selectedServices.includes(service.serviceName)} />
                )))) : (
                    <td colSpan={8}>
                        Нет данных
                    </td>
                )}
            </tbody>
        </table>
        {selectedServices.length > 0 && (
            <div id="hh-services">
            <div className="hh-services__header">Выбранные услуги:</div>
            <ol>
                {selectedServices.map((service) => (
                <li key={service}>
                    {service}
                </li>))}
            </ol>
            </div>
        )}
        </>
    );
};

ServiciesList.propTypes = {
    services: PropTypes.object,
    profAreas: PropTypes.object,
    competitors: PropTypes.object,
    companyName: PropTypes.string,
    companyId: PropTypes.string,
    plainAreas: PropTypes.object,
};

export default ServiciesList;
