import React, {forwardRef} from 'react';
import PropTypes from 'prop-types';

import './Button.css';

const Button = forwardRef(({ children, buttonType, disabled, onClick, outline, ...rest }, ref) => {
    return (
        <button
            ref={ref}
            className={`hh-button ${outline ? "hh-button--outline" : ""}`}
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
    outline: PropTypes.bool,
};

export default Button;
