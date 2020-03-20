import React, {forwardRef} from 'react';

import './Input.css';


const Input = forwardRef(({ children, inputType, placeholderText, onChange, value, ...rest }, ref) => {
    return (
        <input
            ref={ref}
            className="hh-input"
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

export default Input;
