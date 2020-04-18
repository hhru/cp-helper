import React from 'react';
import PropTypes from 'prop-types';

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

SelectItem.propTypes = {
    inputType: PropTypes.string,
    onClick: PropTypes.func.isRequired,
    name: PropTypes.string.isRequired,
};

export default SelectItem;
