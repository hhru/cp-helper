import React from 'react';
import PropTypes from 'prop-types';
import ButtonIcon from 'components/ButtonIcon/ButtonIcon';
import AddIcon from 'components/Icons/AddIcon';

const Service = ({employerName, service, rowspan, firstRow, addService, disabledAddService}) => {
    const {costPerResponse, responsesCount, responsesPerDay, responsesPerSpending, serviceCode, spendingCount} = service;

    return (
    <tr>
        {firstRow && (
        <td rowSpan={rowspan}>
            {employerName}
        </td>
        )}
        {[serviceCode, responsesCount, spendingCount, responsesPerSpending, responsesPerDay, costPerResponse].map((element) => (
            <td key={employerName + serviceCode}>
                {element}
            </td>
        ))}
        <td>
            <ButtonIcon onClick={() => addService(serviceCode)} disabled={disabledAddService}>
                <AddIcon size={30}/>
            </ButtonIcon>
        </td>
    </tr>
    );
};

Service.propTypes = {
    employerName: PropTypes.string,
    service: PropTypes.object,
    rowspan: PropTypes.number,
    firstRow: PropTypes.boolean,
    addService: PropTypes.func,
    disabledAddService: PropTypes.boolean,
};

export default Service;
