import React, {forwardRef} from 'react';
import PropTypes from 'prop-types';

import './Button.css';

const Button = forwardRef(({ children, buttonType, disabled, onClick, ...rest }, ref) => {
    return (
        <button
            ref={ref}
            className="hh-button"
            type={buttonType}
            disabled={disabled}
            onClick={onClick}
            {...rest}>
            {children}
        </button>
    );
});

Button.defaultProps = {
    buttonType: 'button',
    disabled: false,
};

Button.propTypes = {
    children: PropTypes.string.isRequired,
    buttonType: PropTypes.string,
    disabled: PropTypes.bool,
    onClick: PropTypes.func,
};

export default Button;
