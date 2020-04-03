import React from 'react';

import './SelectItem.css';


const SelectItem = ({inputType, onClick, name, ...rest}) => (
    <input
        readOnly
        className="option"
        type={inputType}
        value={name}
        onClick={onClick}
        {...rest}>
    </input>
);

SelectItem.defaultProps = {
    inputType: 'text',
};

export default SelectItem;
