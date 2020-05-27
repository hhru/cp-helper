import React, {useState} from 'react';
import PropTypes from 'prop-types';

import Service from './Service';

import './ServiciesList.css';

const ServiciesList = ({ services, competitors, companyName, companyId }) => {

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

    const COLUMN_NAMES = [
        'Работодатель',
        'Код услуги',
        'Количество откликов',
        'Количество потраченных услуг',
        'Отклик/трата',
        'Откликов в день',
        'Средняя цена отклика',
        ];

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
                {services ? Object.entries(services).map(([employer, services]) => (
                    services.map((service, index) => (
                        <Service
                            employerName={getEmployerName(employer)}
                            key={service.serviceName + service.employerId}
                            service={service}
                            rowspan={employer.length}
                            firstRow={index === 0}
                            addService={addService}
                            disabledAddService={selectedServices.includes(service.serviceCode)} />
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
    competitors: PropTypes.object,
    companyName: PropTypes.string,
    companyId: PropTypes.string,
};

export default ServiciesList;
