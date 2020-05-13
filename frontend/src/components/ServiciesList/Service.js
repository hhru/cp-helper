import React from 'react';
import PropTypes from 'prop-types';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import AddIcon from 'components/Icons/AddIcon';

const Service = ({employerName, profareaName, service, rowspan, firstRow, addService, disabledAddService, areaName}) => {
    const {serviceName, spendingCount, responseCount, responsePerService} = service;

    return (
    <tr>
        {firstRow && (
        <td rowSpan={rowspan}>
            {employerName}
        </td>
        )}
        {[serviceName, areaName, profareaName, spendingCount, responseCount, responsePerService].map((element) => (
            <td key={employerName + serviceName}>
                {element}
            </td>
        ))}
        <td>
            <ButtonIcon onClick={() => addService(serviceName)} disabled={disabledAddService}>
                <AddIcon size={30}/>
            </ButtonIcon>
        </td>
    </tr>
    );
};

Service.propTypes = {
    employerName: PropTypes.string,
    service: PropTypes.object,
    profareaName: PropTypes.string,
    rowspan: PropTypes.number,
    firstRow: PropTypes.boolean,
    addService: PropTypes.func,
    disabledAddService: PropTypes.boolean,
    areaName: PropTypes.string,
};

export default Service;
