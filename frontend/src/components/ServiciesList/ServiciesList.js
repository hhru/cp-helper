import React, {useState, useEffect} from 'react';
import PropTypes from 'prop-types';
import axios from 'axios';
import createNotification from 'utils/notifications';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import AddIcon from 'components/Icons/AddIcon';
import {useSelector} from 'react-redux';
import './ServiciesList.css';

const Service = ({profAreas, service, rowspan, firstRow, addService, disabledAddService}) => {
    const {employerId, serviceName, serviceAreaId, serviceProfArea, spendingCount, responseCount, responsePerService} = service;

    const [areaName, setAreaName] = useState('');
    const [employerName, setEmployerName] = useState('');

    useEffect(async () => {
        try {
            const result = await axios(
                `https://api.hh.ru/areas/${serviceAreaId}`
                );
                setAreaName(result.data.name);
        } catch (error) {
            createNotification('error', `Загрузка региона: ${error}`, 'Ошибка');
        }
    }, [serviceAreaId]);

    useEffect(async () => {
        try {
            const result = await axios(
                `https://api.hh.ru/employers/${employerId}`
                );
                setEmployerName(result.data.name);
        } catch (error) {
            createNotification('error', `Загрузка работодателя: ${error}`, 'Ошибка');
        }
    }, [employerId]);

    return (
    <tr>
        {firstRow && (
        <td rowSpan={rowspan}>
            {`${employerName}\nid: ${employerId}`}
        </td>
        )}
        <td>
            {serviceName}
        </td>
        <td>
            {`${areaName}\nid: ${serviceAreaId}`}
        </td>
        <td>
            {profAreas && profAreas[serviceProfArea]}
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
        <td>
            <ButtonIcon onClick={() => addService(serviceName)} disabled={disabledAddService}>
                <AddIcon size={30}/>
            </ButtonIcon>
        </td>
    </tr>
    );
};

Service.propTypes = {
    service: PropTypes.object,
    profAreas: PropTypes.object,
    rowspan: PropTypes.number,
    firstRow: PropTypes.boolean,
    addService: PropTypes.func,
    disabledAddService: PropTypes.boolean,
};

const ServiciesList = ({ services }) => {

    const profAreas = useSelector((state) => state.profAreas.profAreas);
    const [selectedServices, setSelectedServices] = useState([]);
    const addService = (serviceName) => {
        setSelectedServices([...selectedServices, serviceName]);
    };

    return (
        <>
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
                <td/>
            </tr>
            </thead>
            <tbody className="hh-table__body">
                {services && Object.entries(services).map((employer) => (
                    employer[1].map((service, index) => (
                        <Service
                            key={service.serviceName + service.employerId}
                            service={service}
                            profAreas={profAreas}
                            rowspan={employer[1].length}
                            firstRow={index === 0}
                            addService={addService}
                            disabledAddService={selectedServices.includes(service.serviceName)} />
                    ))))}
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
};

export default ServiciesList;
