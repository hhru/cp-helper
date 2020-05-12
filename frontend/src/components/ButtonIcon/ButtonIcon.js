import React from 'react';
import PropTypes from 'prop-types';

import './ButtonIcon.css';

const ButtonIcon = ({ children, onClick, disabled }) => (
    <button
        className="hh-button-icon"
        onClick={onClick}
        disabled={disabled}>
        {children}
    </button>
);

ButtonIcon.propTypes = {
    children: PropTypes.oneOfType([
        PropTypes.arrayOf(PropTypes.node),
        PropTypes.node,
    ]).isRequired,
    onClick: PropTypes.func.isRequired,
    disabled: PropTypes.bool,
};

export default ButtonIcon;
