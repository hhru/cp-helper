import React, {forwardRef} from 'react';
import PropTypes from 'prop-types';

import './Input.css';

const Input = forwardRef(({ children, inputType, placeholderText, onChange, value, ...rest }, ref) => {
    return (
        <input
            ref={ref}
            className={'hh-input'}
            type={inputType}
            placeholder={placeholderText}
            onChange={onChange}
            value={value}
            {...rest}>
            {children}
        </input>
    );
});

Input.defaultProps = {
    inputType: 'text',
    placeholderText: 'Введите текст',
};

Input.propTypes = {
    children: PropTypes.string,
    inputType: PropTypes.string,
    placeholderText: PropTypes.string,
    onChange: PropTypes.func.isRequired,
    value: PropTypes.string,
};

export default Input;
