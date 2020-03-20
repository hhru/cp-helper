import React, {forwardRef} from 'react';

import './Button.css';


const Button = forwardRef(({ children, buttonType, disabled, ...rest }, ref) => {

    return (
        <button
            ref={ref}
            className="hh-button"
            type={buttonType}
            disabled={disabled}
            {...rest}>
            {children}
        </button>
    );
});

Button.defaultProps = {
    buttonType: 'button',
    disabled: false,
};

export default Button;

